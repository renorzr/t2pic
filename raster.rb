require 'RMagick'
require File.expand_path('picture_extractor', File.dirname(__FILE__))

class Raster
  DEFAULT_POINTSIZE = 20
  DEFAULT_FONT = '/home/reno/fonts/simkai.ttf'
  DEFAULT_TEXT_WIDTH = 500

  def initialize(text, opts = {})
    @image = Magick::ImageList.new
    @picture_extractor = PictureExtractor.new
    @text = text

    @text_width  = (opts[:text_width] || DEFAULT_TEXT_WIDTH).to_i
    @pointsize   = (opts[:pointsize] || DEFAULT_POINTSIZE).to_i
    @font        = opts[:font] || DEFAULT_FONT
    @rows        = (@text.length.to_f / @pointsize).ceil
    @cols        = @text_width / @pointsize
    @vertical    = opts[:vertical] != false
    @text_height = @rows * @pointsize
  end

  def file(format=:jpg)
    path = "/tmp/#{rand(10000)}.jpg"
    pic.write(path)
    return path
  end

  def pic
    @image.push(text_image)
    
    extract_pictures.each do |picture|
      @image.push(picture)
    end

    return @image.append(@vertical)
  end

  def extract_pictures
    extract_urls.map { |url| get_pic(url) }.select { |pic| pic}
  end

  def get_pic(url)
    @picture_extractor.extract(url)
  end

  def extract_urls
    @text.scan(/http:\/\/[^\s]+/)
  end
  
  def text_image
    ts = text_size
    ps = @pointsize
    ft = @font
    return Magick::Image.read("caption:" + @text) do
      self.size      = ts
      self.pointsize = ps
      self.font      = ft
    end.first
  end

  def text_size
    "#{@text_width}x#{@text_height}"
  end
end

