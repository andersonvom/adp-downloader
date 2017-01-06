module IPay
  class PayStatement
    attr_accessor :details, :image

    def initialize(json)
      @data = json
    end

    def id
      File.basename(@data["payDetailUri"]["href"])
    end

    def pay_date
      File.basename(@data["payDate"])
    end

    def image_url
      path = @data["statementImageUri"]["href"]
			path.gsub(/^\/l2/, '') # remove first characters, since it's incorrect o.O
    end

    def details_url
      @data["payDetailUri"]["href"]
    end

    def filename
      "#{@data["payDate"]}-#{id}"
    end

    def pdf
      "#{filename}.pdf"
    end

    def json
      "#{filename}.json"
    end

    def exists?
      File.exists? pdf and File.exists? json
    end

    def save
      File.open(json, 'w') {|f| f.write(details.read)}
      File.open(pdf, 'w') {|f| f.write(image.read)}
    end
  end
end
