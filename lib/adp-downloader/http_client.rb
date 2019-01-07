require "json"
require "mechanize"

module ADPDownloader
  class HttpClient
    def initialize
      # FIXME: https://github.com/andersonvom/adp-downloader/issues/6
      #_raise_on_error(_login(Config.credentials))
    end

    def get(url)
      res = agent.get(url)
      _raise_on_error(res)
      contents = res.body
      contents.to_s.empty? ? {} : JSON.parse(contents)
    end

    def post(url, data)
      agent.post(url, data)
    end

    def download(url)
      agent.get(url).body
    end

    private
    def agent
      headers = {
        "Accept" => "application/json, text/plain, */*",
        "Cookie" => "SMSESSION=#{Config.credentials[:smsession_cookie]}",
      }
      @agent ||= Mechanize.new {|a| a.request_headers = headers}
    end

    def _login(creds)
      agent.post(LOGIN_URL, {
        "target" => TARGET_URL,
        "user" => creds[:username],
        "password" => creds[:password],
      })
    end

    def _raise_on_error(res)
      uri = res.uri.to_s.downcase
      #if not uri.start_with? TARGET_URL or uri.include? "login"
      if uri.include? "login"
        #raise "Unable to authenticate: make sure your username and password are correct"
        raise "Unable to authenticate: make sure the file cookie.txt is up to date"
      end
    end
  end
end
