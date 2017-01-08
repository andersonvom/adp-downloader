require 'io/console'
require 'json'

module ADPDownloader
  class Config
    CREDENTIALS_FILE = File.join(Dir.pwd, "credentials.json")

    def self.credentials
      if File.exists? CREDENTIALS_FILE
        JSON.parse(open(CREDENTIALS_FILE).read)
      else
        {"username" => username, "password" => password}
      end
    end

    private
    def self.username
      print "Username: "
      STDIN.gets.chomp
    end

    def self.password
      print "Password: "
      password = STDIN.noecho(&:gets).chomp
      puts
      password
    end
  end
end
