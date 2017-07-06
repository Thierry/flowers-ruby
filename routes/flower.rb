# Route to show all user flowers
get '/flowers/:flowerid' do
  @flower = Flower.find(params[:flowerid])

  raise "Flower not found" if @flower.nil?
  @flower.to_json
end

# Route to show all user flowers
get '/flowers/:flowerid/petals' do
  @flower = Flower.find(params[:flowerid])

  raise "Flower not found" if @flower.nil?
  @flower.petals.to_json
end

# CREATE: Route to create a new Flower
post '/flowers/:flowerid/petals' do

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.
  @flower = Flower.find(params[:flowerid])
  raise "Flower not found" if @flower.nil?

  begin
    @params_json = JSON.parse(request.body.read)
  rescue
    raise 'Error parsing request'
  end
  @petal = Petal.new(@params_json)
  @petal.flower = @flower

  if @petal.save
    @flower.save
    @petal.to_json
  else
    raise "Error creating petal object"
  end
end

# READ: Route to show a specific Flower based on its `id`
get '/flowers/:id' do
  @flower = Flower.get(params[:id])

  if @flower
    @flower.to_json
  else
    raise "Error creating flower"
  end
end

# UPDATE: Route to update a Petal
put '/flowers/:id' do

  # These next commented lines are for if you are using Backbone.js
  # JSON is sent in the body of the http request. We need to parse the body
  # from a string into JSON
  # params_json = JSON.parse(request.body.read)

  # If you are using jQuery's ajax functions, the data goes through in the
  # params.

  @flower = Flower.find(params[:id])
  @flower.update(params)

  if @flower.save
    @flower.to_json
  else
    raise "Error updating flower"
  end
end

# DELETE: Route to delete a Flower
delete '/flowers/:id' do
  @flower = Flower.get(params[:id])

  if @flower.nil?
    raise "Flower not found"
  end

  @flower.petals.each { |p| p.destroy }

  if @flower.destroy
    {:success => "ok"}.to_json
  else
    raise "Error deleting flower"
  end
end

