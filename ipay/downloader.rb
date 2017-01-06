require_relative './pay_statement'

module IPay
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

    def get_all_statements
      statements.each do |statement|
        if downloaded? statement
          puts "Statement #{statement.filename} already exists"
          next
        else
          puts "Saving #{statement.pay_date} - #{statement.id}..."
          download_statement_files(statement)
        end
      end
    end
  end
end
