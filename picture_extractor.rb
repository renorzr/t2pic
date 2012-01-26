require 'nokogiri'
require File.expand_path('redirect_follower', File.dirname(__FILE__))
require File.expand_path('picture_site_parsers/loader', File.dirname(__FILE__))

class PictureExtractor
  def initialize
    @parsers = ParserLoader.all
  end

  def extract(url)
    @body = RedirectFollower.new(url).resolve.body
    @doc  = Nokogiri::HTML(@body)

    return get_picture
  end

  def get_picture
    picture = nil

    @parsers.each do |parser|
      url = parser.get_picture_url(@body, @doc)
      if url
        data =  RedirectFollower.new(url).resolve.body
        picture = Magick::Image.from_blob(data).first
        break if picture
      end
    end

    return picture
  end
end
