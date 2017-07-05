# Route to show all Petales, ordered like a blog
get '/fleurs' do
  content_type :json
  #@fleurs = Petale.all(:order => :created_at.desc)
  @fleurs = Petale.all()

  @fleurs.to_json
end

# CREATE: Route to create a new Petale
post '/fleurs' do
  content_type :json

  # These next commented lines are for if you are using Backbone.js
  # JSON is sent in the body of the http request. We need to parse the body
  # from a string into JSON
  # params_json = JSON.parse(request.body.read)

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.
  @thing = Petale.new(params)

  if @thing.save
    @thing.to_json
  else
    halt 500
  end
end

# READ: Route to show a specific Petale based on its `id`
get '/fleurs/:id' do
  content_type :json
  @thing = Petale.get(params[:id].to_i)

  if @thing
    @thing.to_json
  else
    halt 404
  end
end

# UPDATE: Route to update a Petale
put '/fleurs/:id' do
  content_type :json

  # These next commented lines are for if you are using Backbone.js
  # JSON is sent in the body of the http request. We need to parse the body
  # from a string into JSON
  # params_json = JSON.parse(request.body.read)

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.

  @thing = Petale.get(params[:id].to_i)
  @thing.update(params)

  if @thing.save
    @thing.to_json
  else
    halt 500
  end
end

# DELETE: Route to delete a Petale
delete '/fleurs/:id/delete' do
  content_type :json
  @thing = Petale.get(params[:id].to_i)

  if @thing.destroy
    {:success => "ok"}.to_json
  else
    halt 500
  end
end

# If there are no Petales in the database, add a few.
#if Petale.count == 0
  #Petale.create(:title => "Test Petale One", :description => "Sometimes I eat pizza.")
  #Petale.create(:title => "Test Petale Two", :description => "Other times I eat cookies.")
#end

#Petale.create(

