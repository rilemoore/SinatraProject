require './config/environment'
use Rack::MethodOverride
use VehiclesController
run ApplicationController