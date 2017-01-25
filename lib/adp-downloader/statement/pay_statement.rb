module ADPDownloader
  class PayStatement < Statement
    def id
      File.basename(pdf_uri, ".*")
    end

    def file_suffix
      "adjustment" if adjustment?
    end

    def adjustment?
      _("payAdjustmentIndicator")
    end

    def date
      _("payDate")
    end

    def json_uri
      _("payDetailUri.href")
    end
  end
end
