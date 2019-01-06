require "io/console"
require "netrc"

module ADPDownloader
  class Config
    class << self
      attr_writer :quiet
      attr_accessor :employer

      def credentials
        from_stdin
      end

      def quiet?
        @quiet
      end

      private
      def creds(username, password, smsession_cookie)
        {
          username: username,
          password: password,
          smsession_cookie: smsession_cookie,
        }
      end

      def from_netrc
        n = Netrc.read
        credential_string = [MACHINE_NAME, employer].compact.join('-')
        username, password = n[credential_string]
        creds(username, password) if username and password
      end

      def read_cookie_file
        cookie_file = "cookie.txt"
        unless File.exists? cookie_file
          puts "Please create a file called 'cookie.txt' in this directory and"
          puts "paste the value of the SMSESSION cookie in it."
          exit 1
        end
        File.read(cookie_file).chomp
      end

      def from_stdin
        # FIXME: https://github.com/andersonvom/adp-downloader/issues/6
        #print "Username: "
        #username = STDIN.gets.chomp
        #print "Password: "
        #password = STDIN.noecho(&:gets).chomp
        #puts
        username = 'currently-not-working'
        password = 'currently-not-working'
        creds(username, password, read_cookie_file)
      end
    end
  end
end
