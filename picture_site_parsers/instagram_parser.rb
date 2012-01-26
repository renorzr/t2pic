module PictureSiteParsers
  class InstagramParser < ParserBase
    def signature
      'instagram-static'
    end

    def extract_picture
      @doc.xpath("//img[@class='photo']").attr('src').value
    end
  end
end

