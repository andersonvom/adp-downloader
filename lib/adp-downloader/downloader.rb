require "parallel"
require "adp-downloader/constants"
require "adp-downloader/statement/pay_statement"
require "adp-downloader/statement/tax_statement"

module ADPDownloader
  class Downloader
    def initialize(http_client)
      @http_client = http_client
    end

    def full_url(path)
      "#{BASE_URL}#{path}"
    end

    def pay_statements
      response = @http_client.get(full_url(PAY_STATEMENTS_PATH))
      response["payStatements"].map { |json| PayStatement.new(json) }
    end

    def tax_statements
      response = @http_client.get(full_url(TAX_STATEMENTS_PATH))
      response["workerTaxStatements"].map { |json| TaxStatement.new(json) }
    end

    def download_statement_files(statement)
      @http_client.download(full_url(statement.json_uri), statement.json)
      @http_client.download(full_url(statement.pdf_uri), statement.pdf)
    end

    def downloaded?(statement)
      File.exists? statement.pdf and File.exists? statement.json
    end

    def download_or_skip_statement(statement)
      if not downloaded? statement
        puts "Saving #{statement.date} - #{statement.id}..."
        download_statement_files(statement)
      end
    end

    def get_all_pay_statements
      Parallel.each(pay_statements) do |statement|
        download_or_skip_statement(statement)
      end
    end

    def get_all_tax_statements
      Parallel.each(tax_statements) do |statement|
        download_or_skip_statement(statement)
      end
    end
  end
end
