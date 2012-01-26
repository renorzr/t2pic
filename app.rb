require 'sinatra'
require File.expand_path("raster", File.dirname(__FILE__))

FONT = '/usr/share/fonts/simkai.ttf'

get '/' do
  text = params[:text]
  send_file(Raster.new(text, :font => FONT).file)
end

