module PictureSiteParsers
  class TwitpicParser < ParserBase
    def signature
      'twitpic.com/show/'
    end

    def extract_picture
      @doc.xpath("//img[@id='photo-display']").attr('src').value
    end
  end
end

