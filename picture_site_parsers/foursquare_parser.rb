module PictureSiteParsers
  class FoursquareParser < ParserBase
    def signature
      '<meta content="foursquare'
    end

    def extract_picture
      @doc.xpath("//div[@class='commentPhoto']/img").attr('src').value
    end
  end
end

