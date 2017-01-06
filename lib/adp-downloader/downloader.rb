require 'parallel'
require_relative './pay_statement'

module ADPDownloader
  class Downloader
    BASE_URL = 'https://my.adp.com'
    ALL_STATEMENTS_PATH = '/v1_0/O/A/payStatements?adjustments=yes&numberoflastpaydates=100'

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

    def download_statement_files(statement)
      @http_client.download(full_url(statement.details_url), statement.json)
      @http_client.download(full_url(statement.image_url), statement.pdf)
    end

    def downloaded?(statement)
      File.exists? statement.pdf and File.exists? statement.json
    end

    def download_or_skip_statement(statement)
      if not downloaded? statement
        puts "Saving #{statement.pay_date} - #{statement.id}..."
        download_statement_files(statement)
      end
    end

    def get_all_statements
      Parallel.each(statements) do |statement|
        download_or_skip_statement(statement)
      end
    end
  end
end
