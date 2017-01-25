module ADPDownloader
  class TaxStatement < Statement
    def id
      _("statementID")
    end

    def date
      _("statementYear.year")
    end

    def employer
      _("employerName")
    end

    def json_uri
      _("statementUri.href")
    end
  end
end
