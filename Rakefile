# Rakefile
require './app'

desc 'List defined routes'
task 'routes' do

  FlowerApp::routes.each_pair do |method, list|
    puts ":: #{method} ::"
    routes = []
    list.each do |item|
      source = item[0].to_s
      item[1].each do |s|
        source.sub!(/\(.+?\)/, ':'+s)   
      end
      routes << source
    end
    puts routes.sort.join("\n")
    puts "\n"
  end

end
