module ADPDownloader
  class Statement
    def initialize(json)
      @data = json
    end

    abstract_methods = %w(id date)

    abstract_methods.each do |method_name|
      define_method method_name do
        raise "You need to define `#{method_name}` for #{self.class}"
      end
    end

    def merge(details)
      top_level_attr, contents = details.first
      { top_level_attr => @data.merge(contents) }
    end

    def filename
      [date, id, file_suffix].compact.join("-")
    end

    def file_suffix
      nil
    end

    def pdf_uri
      path = _("statementImageUri.href")
      path.gsub(/^\/l2/, "") # remove first characters, since it's incorrect o.O
    end

    def year
      date.split("-").first
    end

    def pdf
      File.join(year, "#{filename}.pdf")
    end

    def json
      File.join(year, "#{filename}.json")
    end

    def _(string)
      get_info(@data, string.split("."))
    end

    private
    def get_info(data, attributes)
      return data if attributes.empty?
      attr = attributes.first
      get_info(data[attr] || {}, attributes.drop(1))
    end
  end
end
