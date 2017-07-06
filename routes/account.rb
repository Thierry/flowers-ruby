class FlowerApp < Sinatra::Base
  put '/accounts/:id' do
    Account.maj(params[:id], request.params)
  end

  get '/accounts/:id' do
    Account.get!(params[:id]).to_json
  end
end
