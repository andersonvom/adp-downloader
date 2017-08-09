require "io/console"
require "netrc"

module ADPDownloader
  class Config
    class << self
      attr_writer :quiet
      attr_accessor :employer

      def credentials
        from_netrc or from_stdin
      end

      def quiet?
        @quiet
      end

      private
      def creds(username, password)
        { username: username, password: password }
      end

      def from_netrc
        n = Netrc.read
        credential_string = [MACHINE_NAME, employer].compact.join('-')
        username, password = n[credential_string]
        creds(username, password) if username and password
      end

      def from_stdin
        print "Username: "
        username = STDIN.gets.chomp
        print "Password: "
        password = STDIN.noecho(&:gets).chomp
        puts
        creds(username, password)
      end
    end
  end
end
