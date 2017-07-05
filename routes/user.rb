get '/users' do
  User.all.to_json
end

post '/users' do
  content_type :json
  params[:name] ||= "MyName"
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

