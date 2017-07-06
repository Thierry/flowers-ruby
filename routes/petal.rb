class FlowerApp < Sinatra::Base
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
    update(Petal, params[:id], request.params)
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

end
