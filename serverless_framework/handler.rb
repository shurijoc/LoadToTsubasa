require 'json'
require 'aws-sdk-dynamodb'
require './tld'
require './http_request'

## CrawledSites
# - AttributeName: url
#   AttributeType: S
# - AttributeName: title
#   AttributeType: S
# - AttributeName: page_num
#   AttributeType: N
# - AttributeName: height
#   AttributeType: N
# - AttributeName: created_at
#   AttributeType: S

## CurrentStatuses
# - AttributeName: id
#   AttributeType: S
# - AttributeName: letter 初期値は ` を使う（nextがaのため）
#   AttributeType: S
# - AttributeName: tld_index
#   AttributeType: N
# - AttributeName: total_page_num
#   AttributeType: N
# - AttributeName: current_page_num
#   AttributeType: N

## TwitterStatuses
# - AttributeName: id
#   AttributeType: S
# - AttributeName: tweet_num
#   AttributeType: S

def current_site(event:, context:)
  current_status = list_items('CurrentStatuses').first

  body = {
    current_status: current_status
  }

  response(body: body)
end

def total_site(event:, context:)
  @count ||= count_item('CrawledSites')['Count']

  body = {
    count: @count
  }

  response(body: body)
end

def sites(event:, context:)
  body = {
    sites: list_items('CrawledSites').items
  }

  response(body: body)
end

def crawling(event:, context:)
  status = list_items('CurrentStatuses').first
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

def site_present?(url)
  HttpRequest.get(url)
end

def last_letter?(current_letter)
  current_letter.split('').all? { |s| s == "z" }
end

def add_item(table, event)
  dynamodb_table(table).put_item({ item: event })
end

def increment_tld_index(tld_index)
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
  update_item('CurrentStatuses', key, attributes)
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

# params = event.get('queryStringParameters') # パラメータ取得
