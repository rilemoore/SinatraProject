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
            redirect "/account"
        else
            redirect "vehicles/new"
        end
      end
    
      get '/vehicles/:id' do
        if(!session[:user_id])
          redirect '/failure'
        else 
          @vehicle = Vehicle.find_by(id: params[:id])
          if @vehicle
            erb :'vehicles/show'
          else
            redirect '/vehicles'
          end
        end

      end
    
      get "/vehicles/:id/edit" do
        @vehicle = Vehicle.find_by(id: params[:id])
        if(!!session[:user_id])
          erb :'vehicles/edit'
        else
          redirect '/failure'
        end
      end
    
      patch "/vehicles/:id" do
        @vehicle = Vehicle.find_by(id: params[:id])
        if @vehicle.update(make: params[:make], model: params[:model], money_invested: params[:money_invested])
            redirect "/vehicles/#{@vehicle.id}"
        else
            redirect "/vehicles/#{@vehicle.id}/edit"
        end
      end
    
      delete "/vehicles/:id" do
        @vehicle = Vehicle.find_by(id: params[:id])
        @vehicle.delete
        redirect "/account"
      end
end