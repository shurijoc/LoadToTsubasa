class HttpRequest
  require 'net/http'

  def self.get(url)
    Net::HTTP.get_response(URI.parse(url))
  end
end
