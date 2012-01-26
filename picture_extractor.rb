require 'nokogiri'
require 'curb'
require File.expand_path('picture_site_parsers/loader', File.dirname(__FILE__))

class PictureExtractor
  def initialize
    @parsers = ParserLoader.all
  end

  def extract(url)
    r = Curl::Easy.http_get(url) { |curl| curl.follow_location = true }
    @body = r.body_str
    @doc  = Nokogiri::HTML(r.body_str)

    return get_picture
  end

  def get_picture
    picture = nil

    @parsers.each do |parser|
      url = parser.get_picture_url(@body, @doc)
      picture = Magick::Image.from_blob(Curl::Easy.http_get(url).body_str).first if url
      break if picture
    end

    return picture
  end
end
