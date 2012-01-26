class ParserLoader
  def self.create_parser(parser_name)
    class_name = parser_name.split('_').map { |w| w.capitalize }.join
    return eval("PictureSiteParsers::#{class_name}.new")
  end
  
  def self.all
    parsers_dir = File.dirname(__FILE__)
    require File.expand_path('parser_base', parsers_dir)

    parser_files = Dir.entries(parsers_dir).select do |filename|
      filename.match(/parser\.rb$/)
    end
    
    parsers = parser_files.map do |filename|
      filename.sub(/\.rb$/, '')
    end
    
    all_parsers = []
    parsers.each do |parser|
      require File.expand_path(parser, parsers_dir)
      all_parsers << create_parser(parser)
    end

    return all_parsers
  end
end
