module PictureSiteParsers
  class FlickrParser < ParserBase
    def signature
      'static.flickr.com'
    end

    def extract_picture
      @doc.xpath("//img[@alt='photo']").attr('src').value
    end
  end
end

