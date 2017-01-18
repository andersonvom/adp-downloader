require 'parallel'
require 'adp-downloader/constants'
require 'adp-downloader/pay_statement'

module ADPDownloader
  class Downloader
    def initialize(http_client)
      @http_client = http_client
    end

    def full_url(path)
      "#{BASE_URL}#{path}"
    end

    def statements
      response = @http_client.get(full_url(ALL_STATEMENTS_PATH))
      response["payStatements"].map { |json| PayStatement.new(json) }
    end

    def download_or_skip_statement(statement)
      unless File.exists? statement.json or statement.details_url.nil?
        puts "Saving #{statement.json}..."
        @http_client.download(full_url(statement.details_url), statement.json, true)
      end

      unless File.exists? statement.pdf
        puts "Saving #{statement.pdf}..."
        @http_client.download(full_url(statement.image_url), statement.pdf)
      end
    end

    def get_all_statements
      Parallel.each(statements) do |statement|
        download_or_skip_statement(statement)
      end
    end
  end
end
