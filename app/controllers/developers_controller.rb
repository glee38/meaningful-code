class DevelopersController < ApplicationController
  get "/developers" do
    if dev_logged_in?
      redirect "/developers/#{current_dev.slug}"
    else
      erb :"developers/index"
    end
  end

  get "/developers/signup" do
    @dev = Developer.new
    if dev_logged_in?
      redirect "/developers"
    else
      erb :"developers/developers_signup"
    end   
  end

  post "/developers/signup" do
    @dev = Developer.new(params)
    @dev.valid?

    if @dev.valid?
      @dev.save
      session[:dev_id] = @dev.id
      redirect "/developers/#{@dev.slug}"
    else
      erb :'developers/developers_signup'
    end
  end

  get '/developers/login' do
    if dev_logged_in?
      redirect '/developers'
    else
      erb :'developers/developers_login'
    end
  end

  post "/developers/login" do
    dev = Developer.find_by(username: params[:username])
    if dev && dev.authenticate(params[:password])
      session[:dev_id] = dev.id
      redirect "/developers/#{dev.slug}"
    else
      erb :'developers/developers_login', locals: {message: "Incorrect username and/or password."}
    end
  end

  get "/developers/logout" do
    if dev_logged_in?
      session.clear
      redirect "/"
    else
      redirect "/"
    end
  end

  get '/developers/:slug' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      erb :'/developers/homepage'
    else
      redirect "/login"
    end
  end

end