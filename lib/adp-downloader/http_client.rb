require "json"
require "mechanize"

module ADPDownloader
  class HttpClient
    def initialize
      headers = {"Accept" => "application/json, text/plain, */*"}
      @agent = Mechanize.new {|a| a.request_headers = headers}
      res = _login(Config.credentials)
      _raise_on_error(res)
    end

    def get(url)
      contents = download(url)
      contents.to_s.empty? ? {} : JSON.parse(contents)
    end

    def post(url, data)
      @agent.post(url, data)
    end

    def download(url)
      @agent.get(url).body
    end

    private
    def _login(creds)
      @agent.post(LOGIN_URL, {
        "target" => TARGET_URL,
        "user" => creds[:username],
        "password" => creds[:password],
      })
    end

    def _raise_on_error(res)
      uri = res.uri.to_s.downcase
      if not uri.start_with? TARGET_URL or uri.include? "login"
        raise "Unable to authenticate: make sure your username and password are correct"
      end
    end
  end
end
