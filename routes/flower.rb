class FlowerApp < Sinatra::Base
  # Route to show all user flowers
  get '/flowers/:flowerid' do
    @flower = Flower.find(params[:flowerid])

    raise "Flower not found" if @flower.nil?
    @flower.to_json
  end
  
  # UPDATE: Route to update a Petal
  put '/flowers/:flowerid' do

    @flower = Flower.find(params[:flowerid])
    @flower.update_attributes(request.params)

    if @flower.save
      @flower.to_json
    else
      raise "Error updating flower"
    end
  end

  # Route to show all petals for a flower
  get '/flowers/:flowerid/petals' do
    @flower = Flower.find(params[:flowerid])

    raise "Flower not found" if @flower.nil?
    @flower.petals.sort_by{ |o| o.created_at }.to_json
  end

  # Route to show all accounts for a flower
  get '/flowers/:flowerid/accounts' do
    @flower = Flower.find(params[:flowerid])

    raise "Flower not found" if @flower.nil?
    @flower.accounts.to_json
  end

  # CREATE: Route to create a new petal on this flower
  post '/flowers/:flowerid/petals' do

    # If you are using jQuery's ajax functions, the data goes through in the
    # params.
    @flower = Flower.find(params[:flowerid])
    raise "Flower not found" if @flower.nil?

    begin
      @petal = Petal.new(request.params)
    rescue
      raise "Error creating petal"
    end

    if @petal.save
      @petal.flower = @flower
      @flower.save
      @petal.to_json
    else
      raise "Error creating petal object"
    end
  end

  # CREATE: Route to create a new account on this flower
  post '/flowers/:flowerid/accounts' do

    # If you are using jQuery's ajax functions, the data goes through in the
    # params.
    @flower = Flower.find(params[:flowerid])
    raise "Flower not found" if @flower.nil?

    begin
      @account = Account.new(request.params)
    rescue
      raise "Error creating account"
    end

    if @account.save
      @account.flower = @flower
      #@flower.save
      @account.to_json
    else
      raise "Error creating petal object"
    end
  end

  # DELETE: Route to delete a Flower
  delete '/flowers/:flowerid' do
    @flower = Flower.find(params[:flowerid])

    if @flower.nil?
      raise "Flower not found"
    end

    @flower.petals.each { |p| p.destroy }

    @user = @flower.user
    @user.flowers.delete(@flower)

    if @flower.destroy
      {:success => "ok"}.to_json
    else
      raise "Error deleting flower"
    end
  end

end
