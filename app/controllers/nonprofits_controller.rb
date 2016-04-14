class NonprofitsController < ApplicationController
  get "/nonprofits" do
    if np_logged_in?
      redirect "/nonprofits/#{current_np.slug}"
    else
      erb :"nonprofits/index"
    end
  end

  post '/nonprofits' do
    if np_logged_in?
      redirect "/nonprofits/#{current_np.slug}"
    else
      erb :"nonprofits/index"
    end
  end

  get '/nonprofits/signup' do
    @np = Nonprofit.new
    if np_logged_in?
      redirect "/nonprofits"
    else
      erb :"nonprofits/signup"
    end
  end

  post '/nonprofits/signup' do
    @np = Nonprofit.new(params)
    @np.valid?
    if @np.valid?
      @np.save
      session[:np_id] = @np.id
      redirect "/nonprofits/#{@np.slug}"
    else
      erb :'nonprofits/signup'
    end
  end

  get "/nonprofits/login" do
    if np_logged_in?
      redirect '/nonprofits'
    else
      erb :'nonprofits/login'
    end
  end

  post "/nonprofits/login" do
    np = Nonprofit.find_by(username: params[:username])
    if np && np.authenticate(params[:password])
      session[:np_id] = np.id
      redirect "/nonprofits/#{np.slug}"
    else
      erb :'nonprofits/login', locals: {message: "Incorrect username and/or password."}
    end
  end

  get "/nonprofits/all" do
    erb :'nonprofits/show_nonprofits'
  end

  get "/nonprofits/logout" do
    if np_logged_in?
      session.clear
      redirect "/"
    else
      redirect "/"
    end
  end

  get '/nonprofits/:slug' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :'/nonprofits/homepage'
    else
      redirect "/failure"
    end
  end

  get "/nonprofits/:slug/cause" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :"nonprofits/cause"
    else
      redirect "/failure"
    end 
  end

  get '/nonprofits/:slug/projects' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :"projects/np_projects"
    else
      redirect "/failure"
    end 
  end

    get "/nonprofits/:np_slug/projects/:p_slug" do
    @nonprofit = Nonprofit.find_by_slug(params[:np_slug])
    @project = Project.find_by_slug(params[:p_slug])

    erb :"projects/show_project"
  end

end