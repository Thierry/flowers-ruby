# Route to show all Petals, ordered like a blog
get '/users/:userid/flowers' do
  content_type :json
  @user = User.find(params[:userid])

  halt 500 if @user.nil?
  @flowers = @user.flowers

  @flowers.to_json
end

# CREATE: Route to create a new Petal
post '/users/:userid/flowers' do

  # These next commented lines are for if you are using Backbone.js
  # JSON is sent in the body of the http request. We need to parse the body
  # from a string into JSON
  # params_json = JSON.parse(request.body.read)

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.
  @user = User.find(params[:userid])

  halt 500 if @user.nil?

  begin
    @params_json = JSON.parse(request.body.read)
  rescue
    halt 500
  end
  @flower = Flower.new(@params_json)
  @flower.user = @user

  if @flower.save
    @flower.to_json
  else
    halt 500
  end
end

# READ: Route to show a specific Petal based on its `id`
get '/flowers/:id' do
  content_type :json
  @flower = Flower.get(params[:id].to_i)

  if @flower
    @flower.to_json
  else
    halt 404
  end
end

# UPDATE: Route to update a Petal
put '/flowers/:id' do
  content_type :json

  # These next commented lines are for if you are using Backbone.js
  # JSON is sent in the body of the http request. We need to parse the body
  # from a string into JSON
  # params_json = JSON.parse(request.body.read)

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.

  @flower = Petal.get(params[:id].to_i)
  @flower.update(params)

  if @flower.save
    @flower.to_json
  else
    halt 500
  end
end

# DELETE: Route to delete a Petal
delete '/flowers/:id/delete' do
  content_type :json
  @flower = Petal.get(params[:id].to_i)

  if @flower.destroy
    {:success => "ok"}.to_json
  else
    halt 500
  end
end

# If there are no Petals in the database, add a few.
#if Petal.count == 0
  #Petal.create(:title => "Test Petal One", :description => "Sometimes I eat pizza.")
  #Petal.create(:title => "Test Petal Two", :description => "Other times I eat cookies.")
#end

#Petal.create(

