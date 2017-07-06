# READ: Route to show a specific Petal based on its `id`
get '/petals/:id' do
  @petal = Petal.find(params[:id])

  if @petal
    @petal.to_json
  else
    raise "Petal not found"
  end
end

# UPDATE: Route to update a Petal
put '/petals/:id' do

  # These next commented lines are for if you are using Backbone.js
  # JSON is sent in the body of the http request. We need to parse the body
  # from a string into JSON
  # params_json = JSON.parse(request.body.read)

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.

  @petal = Petal.find(params[:id])
  @petal.update(params)

  if @petal.save
    @petal.to_json
  else
    raise "Error updating petal"
  end
end

# DELETE: Route to delete a Petal
delete '/petals/:id' do
  @petal = Petal.find(params[:id])
  @flower = @petal.flower

  @flower.petals.delete(@petal)

  if @petal.delete
    {:success => "ok"}.to_json
  else
    raise "Cannot delete petal"
  end
end

# If there are no Petals in the database, add a few.
#if Petal.count == 0
  #Petal.create(:title => "Test Petal One", :description => "Sometimes I eat pizza.")
  #Petal.create(:title => "Test Petal Two", :description => "Other times I eat cookies.")
#end

#Petal.create(

