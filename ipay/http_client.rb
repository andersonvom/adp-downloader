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

    def download(url, save_path = nil)
      contents = Typhoeus.get(url, headers: @headers).response_body
      File.open(save_path, 'w') {|f| f.write(contents)} if save_path
      contents
    end
  end
end
