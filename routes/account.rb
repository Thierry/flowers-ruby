class FlowerApp < Sinatra::Base
  get '/accounts' do
    send_file './public/index.html'
  end


end
