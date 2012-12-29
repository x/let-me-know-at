# compile the coffees
require 'rack/coffee_compiler'
use Rack::CoffeeCompiler,
  :source_dir => 'app/coffeescripts',
  :url => '/javascripts',
  :alert_on_error => true

# run the apps
require './app.rb'
run Sinatra::Application
