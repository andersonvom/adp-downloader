require "io/console"
require "netrc"
require "adp-downloader/constants"

module ADPDownloader
  class Config
    def self.credentials
      from_netrc or from_stdin
    end

    private
    def self.creds(username, password)
      { username: username, password: password }
    end

    def self.from_netrc
      n = Netrc.read
      username, password = n[MACHINE_NAME]
      creds(username, password) if username and password
    end

    def self.from_stdin
      print "Username: "
      username = STDIN.gets.chomp
      print "Password: "
      password = STDIN.noecho(&:gets).chomp
      puts
      creds(username, password)
    end
  end
end
