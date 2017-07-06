class FlowerApp < Sinatra::Base
  put '/accounts/:id' do
    update(Account, params[:id], request.params)
  end
end
