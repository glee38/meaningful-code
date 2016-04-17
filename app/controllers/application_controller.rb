require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secretlymeaningful"
  end

  get "/" do
    if dev_logged_in?
      redirect "/developers/#{current_dev.slug}"
    elsif np_logged_in?
      redirect "/nonprofits/#{current_np.slug}"
    else
      erb :index
    end
  end

  get "/about" do
    erb :about
  end

  helpers do
    def dev_logged_in?
      !!session[:dev_id]
    end

    def current_dev
      @current_dev ||= Developer.find(session[:dev_id])
    end

    def np_logged_in?
      !!session[:np_id]
    end

    def current_np
      @current_np ||= Nonprofit.find(session[:np_id])
    end
  end

end