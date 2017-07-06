class FlowerApp < Sinatra::Base
  get '/' do
    send_file './public/index.html'
  end

  get '/routes' do
    content_type :html
    @output = ""
    FlowerApp::routes.each_pair do |method, list|
      @output << ":: #{method} ::<br>"
      routes = []
      list.each do |item|
        source = item[0].to_s
        item[1].each do |s|
          source.sub!(/\(.+?\)/, ':'+s)   
        end
        routes << source
      end
      @output << routes.sort.join("<br>") << "<br>"
    end
    @output
  end

  get '/routes2' do
    content_type :html
    @output = ""
    @routes = Hash.new
    FlowerApp::routes.each_pair do |method, list|
      list.each do |item|
        source = item[0].to_s
        item[1].each do |s|
          source.sub!(/\(.+?\)/, ':'+s)   
        end
        @routes[source] ||= Array.new
        @routes[source] << method
      end
    end
    @routes.sort.to_h.each_pair do |route, methods|
      @output << route << " "
      @output << methods.sort.join(", ")
      @output << "<br>"
    end
    @output
  end
  
end

