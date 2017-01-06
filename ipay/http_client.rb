require 'json'
require 'typhoeus'

module IPay
  class HttpClient
    def initialize(cookies)
      @headers = {
        "Cookie" => cookies,
        "Accept" => "application/json, text/plain, */*",
      }
    end

    def get(url)
      JSON.parse(download(url))
    end

    def download(url, name = nil)
      Typhoeus.get(url, headers: @headers).response_body
    end
  end
end
