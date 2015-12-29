require 'dashing'

configure do

  ENV['RAILS_ENV'] ||= 'development'

  #
  # load environment variables from config/local_env.yml if it exists
  #
  env_file = File.join( 'config', "#{ENV['RAILS_ENV']}_env.yml")
  yaml_file = File.exists?(env_file) ? YAML.load(File.open(env_file)) : nil
  yaml_file.each do |key, value|
    ENV[key.to_s] = value
  end if yaml_file

  set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end

end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application