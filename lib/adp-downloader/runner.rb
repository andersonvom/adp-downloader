require "tempfile"
require "optparse"

module ADPDownloader
  class Runner
    def initialize(arguments)
      @arguments = arguments
    end

    def run
      parse_options
      begin
        downloader = Downloader.new(HttpClient.new)
        downloader.get_statements('pay', downloader.pay_statements)
        # FIXME: downloading tax statements requires extra steps :(
        # downloader.get_statements('tax', downloader.tax_statements)
      rescue Exception => e
        path = log_exception_to_file(e)
        puts "An error ocurred: #{e}"
        puts "Details were logged to #{path}"
        exit 1
      end
    end

    private
    def log_exception_to_file(e)
      file = Tempfile.new("adp-downloader-")
      file.puts(e)
      file.puts(e.backtrace)
      FileUtils.mv file.path, File.join("", "tmp")
      File.join("", "tmp", File.basename(file.path))
    end

    def parse_options
      options = OptionParser.new
      options.banner = "Usage: adp-downloader [options]"
      options.on("-e", "--employer EMP", "Employer name") { |e| Config.employer = e }
      options.on("-v", "--quiet", "Only display errors") { Config.quiet = true }
      options.on("--version", "Display the current version") { puts(VERSION); exit }
      options.on("-h", "--help",  "Show this message")   { puts(options); exit }
      options.parse!(@arguments)
    end
  end
end
