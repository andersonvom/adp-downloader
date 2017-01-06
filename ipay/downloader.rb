require_relative './pay_statement'

module IPay
  class Downloader
    attr_writer :http_client

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

    def get_detailed_statement(statement)
      detailed_statement = statement.dup
      detailed_statement.details = @http_client.download(full_url(statement.details_url))
      detailed_statement.image = @http_client.download(full_url(statement.image_url))
      detailed_statement
    end

    def get_all_statements
      statements.each do |statement|
        if statement.exists?
          puts "Statement #{statement.filename} already exists"
          next
        else
          puts "Saving #{statement.pay_date} - #{statement.id}..."
          detailed_statement = get_detailed_statement(statement)
          detailed_statement.save
        end
      end
    end
  end
end
