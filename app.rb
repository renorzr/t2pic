require 'sinatra'
require File.expand_path("raster", File.dirname(__FILE__))

get '/' do
  text = params[:text]
  send_file(Raster.new(text).file)
end

