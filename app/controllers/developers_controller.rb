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

  get "/developers/:slug/projects/closed" do
    @dev = Developer.find_by_slug(params[:slug])

    if !@dev.nil?
      erb :"developers/closed_projects", :layout => false
    else
      redirect "/developers/failure"
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

  get '/developers/:slug/messages' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          erb :'/developers/show_messages'
        else
          redirect "/developers/#{current_dev.slug}/messages"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  get '/developers/:slug/messages/sent' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          erb :'/developers/sent_messages'
        else
          redirect "/developers/#{current_dev.slug}/messages"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  get '/developers/:slug/messages/recieved' do
    @dev = Developer.find_by_slug(params[:slug])
    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          erb :'/developers/recieved_messages'
        else
          redirect "/developers/#{current_dev.slug}/messages"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  get '/developers/:slug/messages/new' do
    @dev = Developer.find_by_slug(params[:slug])
    @message = Message.new

    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          erb :'/developers/new_message'
        else
          redirect "/developers/#{current_dev.slug}/messages"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  post '/developers/:slug/messages/new' do
    @dev = Developer.find_by_slug(params[:slug])
    @message = Message.new(params[:message])
    @np = Nonprofit.find_by_email(params[:message][:recipient])

    if @message.valid?
      if !@np.nil?
        @message.developer = current_dev
        @message.nonprofit = @np
        @message.date = Date.today
        @message.sender = current_dev.email
        @message.save
        erb :'/developers/show_message', locals: {message: "Message successfully sent!"}
      else
        erb :'/developers/new_message', locals: {message: "Invalid e-mail address."}
      end
    else
      erb :'/developers/new_message'
    end
  end

  get "/developers/:slug/messages/:m_id/reply" do
    @message = Message.find_by_id(params[:m_id])
    erb :'developers/reply', :layout => false
  end

  get '/developers/:slug/messages/:m_id' do
    @message = Message.find_by_id(params[:m_id])
    @dev = Developer.find_by_slug(params[:slug])

    if !@dev.nil?
      if dev_logged_in?
        if current_dev.slug == @dev.slug
          if !@message.nil?
            erb :'/developers/show_message'
          else
            erb :'messages/failure'
          end
        else
          redirect "/developers/#{current_dev.slug}/messages"
        end
      else
        redirect "/developers/#{@dev.slug}"
      end
    else
      redirect "/developers/failure"
    end
  end

  post "/developers/:slug/messages/:m_id" do
    @dev = Developer.find_by_slug(params[:slug])
    @message = Message.find_by_id(params[:m_id])
    @np = @message.nonprofit
    @new_message = Message.new

      if !params[:message][:content].empty?
        @new_message.developer = current_dev
        @new_message.nonprofit = @np
        @new_message.date = Date.today
        @new_message.content = params[:message][:content]
        @new_message.subject = "Re: #{@message.subject}"
        @new_message.recipient = @np.email
        @new_message.sender = current_dev.email
        @new_message.save
        erb :'/developers/show_messages', locals: {message: "Message successfully sent!"} 
      else
        erb :'developers/reply', locals: {message: "Message cannot be empty."} 
      end
  end

  get '/developers/:d_slug/messages/new/:np_slug' do
    @dev = Developer.find_by_slug(params[:d_slug])
    @np = Nonprofit.find_by_slug(params[:np_slug])
    @message = Message.new

    erb :'/developers/new_np_message', :layout => false
  end

  post '/developers/:d_slug/messages/new/:np_slug' do
    @dev = Developer.find_by_slug(params[:d_slug])
    @np = Nonprofit.find_by_slug(params[:np_slug])
    @message = Message.new(params[:message])

    if @message.valid?
      @message.developer = current_dev
      @message.nonprofit = @np
      @message.date = Date.today
      @message.sender = current_dev.email
      @message.save
      erb :'/nonprofits/show_nonprofit', locals: {message: "Message successfully sent!"} 
    else
      erb :'/developers/new_np_message'
    end
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