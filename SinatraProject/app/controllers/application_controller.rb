require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if params[:username].empty?
      redirect '/failure'
    end
    user = User.new(:username => params[:username], :password => params[:password])
		if user.save
      redirect "/login"
    else
      redirect "/failure"
    end

  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
    else
      redirect "/failure"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

get '/vehicles' do
    @vehicles = Vehicle.all
    erb :'vehicles/index_vehicles'
end

get '/vehicles/new' do
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

  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
