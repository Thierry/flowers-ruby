# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")


require_relative 'local/local_config.rb'
require_relative 'models/init'
#require_relative 'helpers/init'
require_relative 'routes/init'

Aws.config.update({
  region: 'eu-west-1',
  credentials: Aws::Credentials.new(AWS_ACCESS_KEY, AWS_SECRET_KEY),
})


configure do
  disable :protection
end
#set :protection, :except => [:json_csrf]

before do
	content_type 'application/json'
end

#set :show_exceptions, false

error do
  content_type :json
  status 400 # or whatever

  e = env['sinatra.error']
  {:result => 'error', :message => e.message}.to_json
end


