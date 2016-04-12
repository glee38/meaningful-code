class DevelopersController < ApplicationController
  get "/developers" do
    if dev_logged_in?
      @dev = current_dev
      erb :'/developers/index'
    else
      redirect 'developers/signup'
    end
  end

  get "/developers/signup" do
    if dev_logged_in?
      redirect '/developers'
    else
      erb :'developers/developers_signup'
    end   
  end

  post "/developers" do
    @dev = Developer.new(params)

    if !@dev.username.empty? && !@dev.email.empty? && @dev.save
      session[:dev_id] = @dev.id
      redirect '/developers'
    else
      erb :'developers/developers_signup', locals: {message: "Missing a required field."}
    end
  end

  get "/developers/logout" do
    if dev_logged_in?
      session.clear
      redirect "/developers"
    else
      redirect "/developers"
    end
  end

end