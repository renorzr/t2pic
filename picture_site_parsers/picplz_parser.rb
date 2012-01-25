module PictureSiteParsers
  class PicplzParser < ParserBase
    def signature
      'picplz'
    end

    def extract_picture
      @doc.xpath("//img[@id='mainImage']").attr('src').value
    end
  end
end
