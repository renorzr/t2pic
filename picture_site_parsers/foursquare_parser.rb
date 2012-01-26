module PictureSiteParsers
  class FoursquareParser < ParserBase
    def signature
      '<meta content="foursquare'
    end

    def extract_picture
      @doc.xpath("//img[@class='mainPhoto']").attr('src').value
    end
  end
end

