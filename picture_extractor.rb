require 'nokogiri'
require File.expand_path('redirect_follower', File.dirname(__FILE__))
require File.expand_path('picture_site_parsers/loader', File.dirname(__FILE__))

class PictureExtractor
  def initialize
    @parsers = ParserLoader.all
  end

  def extract(url)
    @response = RedirectFollower.new(url).resolve
    @doc      = Nokogiri::HTML(@response.body)

    return get_picture
  end

  def get_picture
    data = get_picture_binary
    return data && Magick::Image.from_blob(data).first
  end

  def get_picture_binary
    return @response.body if @response.content_type.match(/image/)

    @parsers.each do |parser|
      url = parser.get_picture_url(@response.body, @doc)
      return url && RedirectFollower.new(url).resolve.body 
    end
  end
end
