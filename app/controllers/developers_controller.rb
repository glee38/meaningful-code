class DevelopersController < ApplicationController
  get "/developers" do
    if dev_logged_in?
      redirect "/developers/#{current_dev.slug}/homepage"
    else
      erb :"developers/index"
    end
  end

  post '/developers' do
    if dev_logged_in?
      redirect "/developers/#{current_dev.slug}/homepage"
    elsif np_logged_in?
      redirect "/nonprofits/#{current_np.slug}"
    else
      erb :"developers/index"
    end
  end

  get "/developers/signup" do
    @dev = Developer.new
    if dev_logged_in?
      redirect "/developers"
    else
      erb :"developers/signup"
    end   
  end

  post "/developers/signup" do
    @dev = Developer.new(params)
    @dev.valid?

    if @dev.valid?
      @dev.save
      session[:dev_id] = @dev.id
      redirect "/developers/#{@dev.slug}/homepage"
    else
      erb :'developers/signup'
    end
  end

  get '/developers/login' do
    if dev_logged_in?
      redirect "/developers/#{current_dev.slug}/homepage"
    else
      erb :'developers/login'
    end
  end

  post "/developers/login" do
    dev = Developer.find_by(username: params[:username])
    if dev && dev.authenticate(params[:password])
      session[:dev_id] = dev.id
      redirect "/developers/#{dev.slug}/homepage"
    else
      erb :'developers/login', locals: {message: "Incorrect username and/or password."}
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

  get "/developers/all" do
    erb :'developers/all_developers'
  end

  get '/developers/message' do
    erb :'/developers/message'
  end

  get '/developers/failure' do
    erb :'developers/failure'
  end

  get '/developers/:slug/projects' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      erb :'/projects/dev_projects'
    else
      redirect "developers/failure"
    end
  end

  get '/developers/:slug/projects/edit' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          erb :'/developers/edit_projects'
        else
          redirect "/developers/#{current_dev.slug}"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  post '/developers/:slug/projects/edit' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          erb :'/developers/edit_projects'
        else
          redirect "/developers/#{current_dev.slug}"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  patch '/developers/:slug/projects/edit' do
    @dev = Developer.find_by_slug(params[:slug])

      @project_ids = @dev.project_ids
      @to_delete = params[:dev][:project_ids]
      @project_ids.delete_if {|p| @to_delete.include?(p.to_s)}
      @dev.update(project_ids: @project_ids)

      erb :"/developers/edit_projects", locals: {message: "Project(s) successfully removed."} 
  end

  get '/developers/:slug/homepage' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      if @dev == current_dev
        erb :'/developers/homepage'
      else
        redirect "developers/login"
      end
    else
      redirect "/developers/failure"
    end
  end

  get "/developers/:slug/edit" do
    @dev = Developer.find_by_slug(params[:slug])
    if current_dev.slug == @dev.slug
      erb :'/developers/edit'
    else
      redirect "/developers/#{current_dev.slug}"
    end
  end

  post "/developers/:slug/edit" do
    @dev = Developer.find_by_slug(params[:slug])
    if current_dev.slug == @dev.slug
      erb :'/developers/edit'
    else
      redirect "/developers/#{current_dev.slug}"
    end
  end

  get '/developers/:slug/nonprofits' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      erb :'/developers/dev_nonprofits'
    else
      redirect "developers/failure"
    end
  end

  get '/developers/:slug' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      erb :'/developers/show_developer'
    else
      redirect "developers/failure"
    end
  end

  patch '/developers/:slug' do
    @dev = Developer.find_by_slug(params[:slug])
    if current_dev.slug == @dev.slug
      @dev.update(params[:dev])
      erb :'/developers/show_developer', locals: {message: "Profile successfully updated!"}
    else
      redirect "/developers/#{current_dev.slug}"
    end
  end

end