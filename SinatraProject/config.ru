require './config/environment'
# rack method override
use VehiclesController
run ApplicationController