require 'json'
require 'mechanize'

module ADPDownloader
  class HttpClient
    LOGIN_URL = "https://agateway.adp.com/siteminderagent/forms/login.fcc"
    TARGET_URL = "https://my.adp.com/static/redbox/"
    CREDENTIALS_FILE = File.join(Dir.pwd, "credentials.json")

    def initialize
      headers = {"Accept" => "application/json, text/plain, */*"}
      @agent = Mechanize.new {|a| a.request_headers = headers}
      _login(JSON.parse(open(CREDENTIALS_FILE).read))
    end

    def _login(creds)
      @agent.post(LOGIN_URL, {
        "target" => TARGET_URL,
        "user" => creds["username"],
        "password" => creds["password"],
      })
    end

    def get(url)
      JSON.parse(download(url))
    end

    def post(url, data)
      @agent.post(url, data)
    end

    def download(url, save_path = nil)
      contents = @agent.get(url).body
      File.open(save_path, 'w') {|f| f.write(contents)} if save_path
      contents
    end
  end
end