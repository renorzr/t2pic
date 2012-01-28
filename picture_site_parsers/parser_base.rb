module PictureSiteParsers
  class ParserBase
    def get_picture_url(body, doc)
      @body = body
      @doc = doc
      return false unless is_the_site?
      return extract_picture
    rescue
      return nil
    end

    def is_the_site?
      @body.include?(signature)
    end
  end
end
