require 'adp-downloader/statement/statement'

module ADPDownloader
  class PayStatement < Statement
    def id
      File.basename(pdf_uri, ".*")
    end

    def dirname
      PAY_DIR
    end

    def date
      _("payDate")
    end

    def json_uri
      _("payDetailUri.href")
    end
  end
end
