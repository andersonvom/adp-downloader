module ADPDownloader
  class PayStatement
    def initialize(json)
      @data = json
    end

    def id
      path = File.basename(@data["statementImageUri"]["href"])
      path.gsub(/\.pdf/, '')
    end

    def pay_date
      File.basename(@data["payDate"])
    end

    def image_url
      path = @data["statementImageUri"]["href"]
      path.gsub(/^\/l2/, '') # remove first characters, since it's incorrect o.O
    end

    def details_url
      if @data["payDetailUri"] && @data["payDetailUri"]["href"]
        return @data["payDetailUri"]["href"]
      else
        return nil
      end
    end

    def adjustment?
      @data["payAdjustmentIndicator"]
    end

    def filename
      if adjustment?
        return "#{@data["payDate"]} #{id} - Adjustment"
      else
        return "#{@data["payDate"]} #{id}"
      end
    end

    def pdf
      "pdf/#{filename}.pdf"
    end

    def json
      "json/#{filename}.json"
    end
  end
end
