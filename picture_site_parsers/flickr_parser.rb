module PictureSiteParsers
  class FlickrParser < ParserBase
    def signature
      'Flickr'
    end

    def extract_picture
      @doc.xpath("//img[@alt='photo']").attr('src').value
    end
  end
end

