require 'json'
require 'mechanize'
require 'adp-downloader/config'
require 'adp-downloader/constants'

module ADPDownloader
  class HttpClient
    def initialize
      headers = {"Accept" => "application/json, text/plain, */*"}
      @agent = Mechanize.new {|a| a.request_headers = headers}
      res = _login(Config.credentials)
      _raise_on_error(res)
    end

    def get(url)
      JSON.parse(download(url))
    end

    def post(url, data)
      @agent.post(url, data)
    end

    def download(url, save_path = nil)
      contents = @agent.get(url).body
      _save(contents, save_path) if save_path
      contents
    end

    private
    def _save(contents, path)
      FileUtils.mkpath(File.dirname(path))
      File.open(path, 'w') { |f| f.write(contents) }
    end

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
