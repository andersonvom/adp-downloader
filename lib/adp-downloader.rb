require_relative './adp-downloader/downloader'
require_relative './adp-downloader/http_client'
require_relative './adp-downloader/pay_statement'

module ADPDownloader
  def self.download
    begin
      downloader = Downloader.new(HttpClient.new)
      downloader.get_all_statements
    rescue Exception => e
      path = log_exception_to_file(e)
      puts "An error ocurred: #{e}"
      puts "Details were logged to #{path}"
      exit 1
    end
  end

  private
  def self.log_exception_to_file(e)
    file = Tempfile.new
    file.puts(e)
    file.puts(e.backtrace)
    FileUtils.mv file.path, File.join("", "tmp")
    File.join("", "tmp", File.basename(file.path))
  end
end
