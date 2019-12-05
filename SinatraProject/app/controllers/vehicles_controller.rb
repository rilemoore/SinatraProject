class VehiclesController < ApplicationController
    
    get '/vehicles' do
        @vehicles = Vehicle.all
        erb :'vehicles/index_vehicles'
      end
    
      get '/vehicles/new' do
        if(session[:user_id])
          @current_user = User.find(session[:user_id])
        else
          redirect '/failure'
        end
    
        
        @users = User.all
        erb :'vehicles/new'
      end
    
      post '/vehicles' do
        user = User.find_by(id: params[:user_id])
        vehicle = user.vehicles.build(params)
        if vehicle.save
            redirect "/vehicles"
        else
            redirect "vehicles/new"
        end
      end
    
      get '/vehicles/:id' do
        @vehicle = Vehicle.find_by(id: params[:id])
        if @vehicle
            erb :'vehicles/show'
        else
            redirect '/vehicles'
        end
      end
    
      get "/vehicles/:id/edit" do
        @users = User.all
        @vehicle = Vehicle.find_by(id: params[:id])
        erb :'vehicles/edit'
      end
    
      patch "/vehicles/:id" do
        @vehicle = Vehicle.find_by(id: params[:id])
        if @vehicle.update(title: params[:title], body: params[:body])
            redirect "/vehicles/#{@vehicle.id}"
        else
            redirect "/vehicles/#{@vehicle.id}/edit"
        end
      end
    
      delete "/vehicles/:id" do
        @vehicle = Vehicle.find_by(id: params[:id])
        @vehicle.delete
        redirect "/vehicles"
      end
end