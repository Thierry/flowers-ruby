# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

require_relative 'local/local_config.rb'

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(AWS_ACCESS_KEY, AWS_SECRET_KEY),
})

# Define a simple DataMapper model.
class Petale
  #include DataMapper::Resource
  include Dynamoid::Document
  #table :name => :awesome_users, :key => :user_id, :read_capacity => 5, :write_capacity => 5
  field :name
  field :class
  #field :rank, :integer
  #field :number, :number
  #field :joined_at, :datetime
  #field :hash, :serialized
  field :enabled, :integer

end

class AccountPetale < Petale
  field :IBAN
  

end

class Fleur
  include Dynamoid::Document 

  has_many :petales
end


# Finalize the DataMapper models.
#DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
#DataMapper.auto_upgrade!

get '/' do
  send_file './public/index.html'
end

# Route to show all Petales, ordered like a blog
get '/things' do
  content_type :json
  @things = Petale.all(:order => :created_at.desc)

  @things.to_json
end

# CREATE: Route to create a new Petale
post '/things' do
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
get '/things/:id' do
  content_type :json
  @thing = Petale.get(params[:id].to_i)

  if @thing
    @thing.to_json
  else
    halt 404
  end
end

# UPDATE: Route to update a Petale
put '/things/:id' do
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
delete '/things/:id/delete' do
  content_type :json
  @thing = Petale.get(params[:id].to_i)

  if @thing.destroy
    {:success => "ok"}.to_json
  else
    halt 500
  end
end

# If there are no Petales in the database, add a few.
if Petale.count == 0
  Petale.create(:title => "Test Petale One", :description => "Sometimes I eat pizza.")
  Petale.create(:title => "Test Petale Two", :description => "Other times I eat cookies.")
end
