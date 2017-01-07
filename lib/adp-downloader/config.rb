require 'json'

module ADPDownloader
  class Config
    CREDENTIALS_FILE = File.join(Dir.pwd, "credentials.json")

    def self.credentials
      JSON.parse(read_credentials_file)
    end

    def self.read_credentials_file
      if File.exists? CREDENTIALS_FILE
        open(CREDENTIALS_FILE).read
      else
        puts "Please create the credentials.json file"
        exit 1
      end
    end
  end
end
