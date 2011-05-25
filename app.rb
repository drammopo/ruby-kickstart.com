require 'bundler/setup'
require 'yaml'
require 'sinatra'
require 'active_record'

# activerecord
case settings.environment  
when 'production', :production
  database_file = "/data/rubykickstartcom/shared/config/database.yml"
when 'development', :development
  database_file = File.dirname(__FILE__) + "/db/database.yml"
end
database_config = YAML.load( File.read database_file )[ settings.environment.to_s ]
ActiveRecord::Base.establish_connection(database_config)

# load models
models_dir = File.dirname(__FILE__) + "/app/models"
Dir[models_dir].each do |model|
  next unless model =~ /\.rb$/
  require model
end

# set views
set :views, File.dirname(__FILE__) + '/app/views'


get '/' do
  haml :home
end
