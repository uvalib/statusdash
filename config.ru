require 'dashing'

configure do

  ENV['RAILS_ENV'] ||= 'development'

  ENV[ 'TITLE_PREFIX' ] ||= 'Development'

  #
  # load environment variables from config/local_env.yml if it exists
  #
  env_file = File.join( 'config', 'local_env.yml' )

  begin
    config_erb = ERB.new( IO.read( env_file ) ).result( binding )
  rescue StandardError => e
    raise( "#{filename} could not be parsed with ERB. \n#{e.inspect}" )
  end

  begin
    CONFIG = YAML.load( config_erb )
  rescue Psych::SyntaxError => e
    raise "#{filename} could not be parsed as YAML. \nError #{e.message}"
  end

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