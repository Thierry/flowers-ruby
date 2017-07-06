class FlowerApp < Sinatra::Base
  get '/users' do
    User.all.to_json
  end

  get '/users/:id' do

    @user = User.find(params[:id])

    if @user
      @user.to_json
    else
      raise "Unknown user"
    end
  end

  post '/users' do
    @user = User.new(params)


    if @user.save
      @flower = Flower.new(:label => "First flower", :description => "My first flower")
      @flower.user = @user
      @flower.save
      @user.to_json
    else
      raise "Error creating user"
    end
  end

  put '/users/:id' do

    @user = User.find(params[:id])
    @user.update_attributes(request.params)

    if @user.save
      @user.to_json
    else
      raise "Error updating user"
    end
  end
  #
  # Route to show all user flowers
  get '/users/:userid/flowers' do
    content_type :json
    @user = User.find(params[:userid])

    raise "User not found" if @user.nil?
    @user.flowers.to_json
  end

  # CREATE: Route to create a new Flower
  post '/users/:userid/flowers' do

    # These next commented lines are for if you are using Backbone.js
    # JSON is sent in the body of the http request. We need to parse the body
    # from a string into JSON
    # params_json = JSON.parse(request.body.read)

    # If you are using jQuery's ajax functions, the data goes through in the
    # params.
    @user = User.find(params[:userid])
    raise "User not found" if @user.nil?

    @flower = Flower.new(request.params)
    @flower.user = @user

    @user.flowers << @flower
    @user.save

    if @flower.save
      @flower.to_json
    else
      raise "Error creating flower object"
    end
  end

end
