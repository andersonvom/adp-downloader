require 'json'
require 'typhoeus'

module IPay
  class Auth
    LOGIN_URL = "https://agateway.adp.com/siteminderagent/forms/login.fcc"
    TARGET_URL = "https://my.adp.com/static/redbox/"
    CREDENTIALS_FILE = File.join(Dir.pwd, "credentials.json")

    def creds
      @creds ||= JSON.parse(open(CREDENTIALS_FILE).read)
    end

    def login(username, password)
      Typhoeus::Request.new(
        LOGIN_URL,
        method: "POST",
        body: {
          "target" => TARGET_URL,
          "user" => username,
          "password" => password,
        },
      ).run
    end

    def follow(login_response)
      cookie = login_response.headers["Set-Cookie"].gsub(/ .*/, '')
      Typhoeus::Request.new(
        TARGET_URL,
        headers: { "Cookie" => cookie },
      ).run
    end

    def session_cookie
      res = follow(login(creds['username'], creds['password']))
      cookies = res.headers["Set-Cookie"]
      session_cookie = cookies.find { |cookie| /SMSESSION/ =~ cookie }
      session_cookie.gsub(/ .*/, '')
    end
  end
end
