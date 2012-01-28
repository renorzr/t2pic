require 'sinatra'
require File.expand_path("raster", File.dirname(__FILE__))

FONT = '/usr/share/fonts/simkai.ttf'

get '/' do
  puts 'get', params
  proceed(params)
end

post '/' do
  puts 'post', params
  proceed(params)
end

def proceed(params)
  text = params[:text]
  pic = params[:pic]
  send_file(Raster.new(text, :font => FONT, :pic => pic).file)
end
