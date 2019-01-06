require "json"
require "parallel"

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
      response.fetch("payStatements", []).map { |json| PayStatement.new(json) }
    end

    def tax_statements
      response = @http_client.get(full_url(TAX_STATEMENTS_PATH))
      response.fetch("workerTaxStatements", []).map { |json| TaxStatement.new(json) }
    end

    def download_statement_files(statement)
      if statement.json_uri
        json = @http_client.get(full_url(statement.json_uri)) if statement.json_uri
        _save(JSON.pretty_generate(statement.merge(json)), statement.json)
      end

      pdf = @http_client.download(full_url(statement.pdf_uri))
      _save(pdf, statement.pdf)
    end

    def downloaded?(statement)
      File.exists? statement.pdf
    end

    def download_or_skip_statement(statement)
      if not downloaded? statement
        puts "Saving #{statement.date} - #{statement.id}..." unless Config.quiet?
        download_statement_files(statement)
      end
    end

    def get_statements(type, statements)
      puts "Downloading all #{type} statements..." unless Config.quiet?
      Parallel.each(statements) do |statement|
        download_or_skip_statement(statement)
      end
    end

    private
    def _save(contents, path)
      FileUtils.mkpath(File.dirname(path))
      File.open(path, "w") { |f| f.write(contents) }
    end
  end
end
