require 'RMagick'
require File.expand_path('picture_extractor', File.dirname(__FILE__))

class Raster
  DEFAULT_POINTSIZE = 20
  DEFAULT_TEXT_WIDTH = 500
  PICTURE_EXTRACTOR = PictureExtractor.new

  def initialize(text, opts = {})
    @image   = Magick::ImageList.new
    @text    = text
    @pic_url = opts[:pic]

    @pointsize = (opts[:pointsize] || DEFAULT_POINTSIZE).to_i
    @font      = opts[:font]
    @vertical  = opts[:vertical] != false

    max_text_width = (opts[:text_width] || DEFAULT_TEXT_WIDTH).to_i
    @cols          = max_text_width / @pointsize
    @rows          = (@text.length.to_f / @cols).ceil
    @text_width    = (@rows == 1) ? one_row_text_width : max_text_width
    @text_height   = (@rows + 1) * @pointsize
  end

  def one_row_text_width
    (@text.length+1) * @pointsize
  end

  def file(format=:jpg)
    path = "/tmp/#{rand(10000)}.jpg"
    pic.write(path)
    return path
  end

  def pic
    @image.push(text_image)
    add_specified_picture
    add_extracted_pictures

    return @image.append(@vertical)
  end

  def add_specified_picture
    data = @pic_url && get_pic(@pic_url)
    @image.push(data) if data
  end

  def add_extracted_pictures
    extract_pictures.each do |picture|
      @image.push(picture)
    end
  end

  def extract_pictures
    extract_urls.map { |url| get_pic(url) }.select { |pic| pic}
  end

  def get_pic(url)
    PICTURE_EXTRACTOR.extract(url)
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

