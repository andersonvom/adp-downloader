require "adp-downloader/downloader"
require "adp-downloader/http_client"

module ADPDownloader
  def self.download
    begin
      downloader = Downloader.new(HttpClient.new)
      downloader.get_all_tax_statements
      downloader.get_all_pay_statements
    rescue Exception => e
      path = log_exception_to_file(e)
      puts "An error ocurred: #{e}"
      puts "Details were logged to #{path}"
      exit 1
    end
  end

  private
  def self.log_exception_to_file(e)
    file = Tempfile.new("adp-downloader-")
    file.puts(e)
    file.puts(e.backtrace)
    FileUtils.mv file.path, File.join("", "tmp")
    File.join("", "tmp", File.basename(file.path))
  end
end
