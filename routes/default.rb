get '/' do
  send_file './public/index.html'
end

get '/routes' do
  #content_type :html
  Sinatra::Application.routes["GET"].each do |route|
    puts route[0]
  end
end


