require 'json'
require 'open-uri'

module IPay
  class HttpClient
    def initialize(cookies)
      @cookies = cookies
    end

    def get(url)
      JSON.parse(download(url).read)
    end

    def download(url, name = nil)
      open(url, "Cookie" => @cookies)
    end
  end
end
