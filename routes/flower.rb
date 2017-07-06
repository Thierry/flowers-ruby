class FlowerApp < Sinatra::Base
  # Route to show all user flowers
  get '/flowers/:id' do
    @flower = Flower.get(params[:id])

    raise "Flower not found" if @flower.nil?
    @flower.to_json
  end
  
  # UPDATE: Route to update a Petal
  put '/flowers/:id' do
    Flower.maj(params[:id], request.params).to_json
  end

  # Route to show all petals for a flower
  get '/flowers/:id/petals' do
    @flower = Flower.find(params[:id])

    raise "Flower not found" if @flower.nil?
    @flower.petals.sort_by{ |o| o.created_at }.to_json
  end

  # Route to show all accounts for a flower
  get '/flowers/:id/accounts' do
    @flower = Flower.find(params[:id])

    raise "Flower not found" if @flower.nil?
    @flower.accounts.to_json
  end

  # CREATE: Route to create a new petal on this flower
  post '/flowers/:id/petals' do

    # If you are using jQuery's ajax functions, the data goes through in the
    # params.
    @flower = Flower.find(params[:id])
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
  post '/flowers/:id/accounts' do

    # If you are using jQuery's ajax functions, the data goes through in the
    # params.
    @flower = Flower.find(params[:id])
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
  delete '/flowers/:id' do
    @flower = Flower.find(params[:id])

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
