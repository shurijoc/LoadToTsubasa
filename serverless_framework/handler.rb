require 'json'
require 'aws-sdk-dynamodb'
require 'twilio-ruby'
require './http_request'

## CalledTels
# - AttributeName: tel
#   AttributeType: S
# - AttributeName: created_at
#   AttributeType: S

## Statuses
# - id: S
# - totalYes: N
# - calling: N(0 or 1)
# - currentTel: S

def current_tel(event:, context:)
  current_status = list_items('Statuses').first

  body = {
    current_status: current_status
  }

  response(body: body)
end

def total_tel(event:, context:)
  @count ||= count_item('CalledTels')['Count']

  body = {
    total_tel: @count
  }

  response(body: body)
end

def tels(event:, context:)
  body = {
    tels: list_items('CalledTels').items
  }

  response(body: body)
end

def calling(event:, context:)
  status = list_items('Statuses').first
  current_letter = status['letter']
  next_letter = current_letter.next
  tld_index = status['tld_index']

  url = "#{next_letter}.#{Tld::ALL[tld_index]}"

  increment_tld_index(tld_index) if last_letter?(current_letter)
end

private

def response(body:, status_code: 200)
  {
    statusCode: status_code,
    body: body.to_json
  }
end

def tel_present?(url)
  HttpRequest.get(url)
end

def add_item(table, event)
  dynamodb_table(table).put_item({ item: event })
end

def increment_tel(tel)
  key = { 'id': 1.to_s }

  attributes = {
    "UpdateExpression": "set #tld_index = :tld_index",
    "ExpressionAttributeNames": {
      "#tld_index": "tld_index"
    },
    "ExpressionAttributeValues": {
      ":tld_index": tld_index + 1,
    }
  }
  update_item('Statuses', key, attributes)
end

def update_item(table, key, attributes)
  params = {
    table_name: table,
    key: key,
    attribute_updates: attributes
  }

  dynamodb_table(table).update_item(params)
end

def list_items(table)
  dynamodb_table(table).scan({ limit: 50, select: 'ALL_ATTRIBUTES' })
end

def dynamodb_table(table)
  resource = Aws::DynamoDB::Resource.new(region: 'ap-northeast-1')
  table = resource.table(table)
end

def count_item(table)
  dynamodb_table(table).scan({ select: 'COUNT' })
end

def twilio_calling(to)
  account_sid = "ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" # Your Test Account SID from www.twilio.com/console/settings
  auth_token = "your_auth_token"   # Your Test Auth Token from www.twilio.com/console/settings

  response = Twilio::TwiML::VoiceResponse.new(account_sid, auth_token) do |r|
    r.gather numDigits: 1 do |g|
      g.say(
        message: 'For sales, press 1. For support, press 2.',
        to: "+81#{to}", # Replace with your phone number
        from: "+15005550006" # Use this Magic Number for creating SMS
      )
    end
    r.redirect('/voice')
  end

  puts response
end

# params = event.get('queryStringParameters') # パラメータ取得
