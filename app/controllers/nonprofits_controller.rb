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
      redirect "/nonprofits/#{np.slug}/homepage"
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

  get "/nonprofits/failure" do
    erb :"nonprofits/failure"
  end

  get '/nonprofits/:slug' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :'/nonprofits/show_nonprofit'
    else
      redirect "/nonprofits/failure"
    end
  end

  get "/nonprofits/:id/edit" do
    @np = Nonprofit.find_by_id(params[:id])
    if !@np.nil?
      if np_logged_in?
        if current_np.id == @np.id
          erb :'/nonprofits/edit'
        else
          redirect "/nonprofits/#{current_np.slug}"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post "/nonprofits/:id/edit" do
    @np = Nonprofit.find_by_id(params[:id])
    if !@np.nil?
      if np_logged_in?
        if current_np.id == @np.id
          erb :'/nonprofits/edit'
        else
          redirect "/nonprofits/#{current_np.slug}"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  patch "/nonprofits/:id/edit" do
    @np = Nonprofit.find_by_id(params[:id])

    if np_logged_in?
      if current_np.slug == @np.slug
      @np.attributes=(params[:np])
      @np.valid?
        if @np.valid?
          @np.save
          redirect "nonprofits/#{current_np.slug}"
        else
          erb :'nonprofits/edit'
        end
      else
      redirect "nonprofits/#{current_np.slug}"
      end
    else
      redirect "nonprofits/all"
    end
  end

  get "/nonprofits/:slug/homepage" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if current_np.slug == @np.slug
        erb :'/nonprofits/homepage'
      else
        redirect "nonprofits/login"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  get "/nonprofits/:slug/cause" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :"nonprofits/cause"
    else
      redirect "/nonprofits/failure"
    end 
  end

  get '/nonprofits/:slug/projects' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :"projects/np_projects"
    else
      redirect "/nonprofits/failure"
    end 
  end

  get '/nonprofits/:slug/developers' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      erb :"nonprofits/np_developers"
    else
      redirect "/nonprofits/failure"
    end 
  end

  get '/nonprofits/:slug/messages' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :'/nonprofits/show_messages'
        else
          redirect "/nonprofits/#{current_np.slug}/messages"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  get '/nonprofits/:slug/messages/sent' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :'/nonprofits/sent_messages'
        else
          redirect "/nonprofits/#{current_np.slug}/messages"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  get '/nonprofits/:slug/messages/recieved' do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :'/nonprofits/recieved_messages'
        else
          redirect "/nonprofits/#{current_np.slug}/messages"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  get '/nonprofits/:slug/messages/new' do
    @np = Nonprofit.find_by_slug(params[:slug])
    @message = Message.new

    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :'/nonprofits/new_message'
        else
          redirect "/nonprofits/#{current_np.slug}/messages"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post '/nonprofits/:slug/messages/new' do
    @np = Nonprofit.find_by_slug(params[:slug])
    @message = Message.new(params[:message])
    @dev = Developer.find_by_email(params[:message][:recipient])

    if @message.valid?
      if !@dev.nil?
        @message.developer = @dev
        @message.nonprofit = current_np
        @message.date = Date.today
        @message.sender = current_np.email
        @message.save
        erb :'/nonprofits/show_message', locals: {message: "Message successfully sent!"}
      else
        erb :'/nonprofits/new_message', locals: {message: "Invalid e-mail address."}
      end
    else
      erb :'/nonprofits/new_message'
    end
  end

  get '/nonprofits/:np_slug/messages/new/:d_slug' do
    @dev = Developer.find_by_slug(params[:d_slug])
    @np = Nonprofit.find_by_slug(params[:np_slug])
    @message = Message.new

    erb :'/nonprofits/new_dev_message', :layout => false
  end

  post '/nonprofits/:np_slug/messages/new/:d_slug' do
    @dev = Developer.find_by_slug(params[:d_slug])
    @np = Nonprofit.find_by_slug(params[:np_slug])
    @message = Message.new(params[:message])

    if @message.valid?
      @message.developer = @dev
      @message.nonprofit = current_np
      @message.date = Date.today
      @message.sender = current_np.email
      @message.save
      erb :'/developers/show_developer', locals: {message: "Message successfully sent!"} 
    else
      erb :'/nonprofits/new_dev_message'
    end
  end

  get '/nonprofits/:slug/messages/:m_id/reply' do
    @message = Message.find_by_id(params[:m_id])
    erb :'nonprofits/reply', :layout => false
  end

  get '/nonprofits/:slug/messages/:m_id' do
    @message = Message.find_by_id(params[:m_id])
    @np = Nonprofit.find_by_slug(params[:slug])

    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          if !@message.nil?
            erb :'/nonprofits/show_message'
          else
            erb :'messages/failure'
          end
        else
          redirect "/nonprofits/#{current_np.slug}/messages"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post '/nonprofits/:slug/messages/:m_id' do
    @np = Nonprofit.find_by_slug(params[:slug])
    @message = Message.find_by_id(params[:m_id])
    @dev = @message.developer
    @new_message = Message.new

      if !params[:message][:content].empty?
        @new_message.developer = @dev
        @new_message.nonprofit = current_np
        @new_message.date = Date.today
        @new_message.content = params[:message][:content]
        @new_message.subject = "Re: #{@message.subject}"
        @new_message.recipient = @dev.email
        @new_message.sender = current_np.email
        @new_message.save
        erb :'/nonprofits/show_messages', locals: {message: "Message successfully sent!"} 
      else
        erb :'nonprofits/reply', locals: {message: "Message cannot be empty."} 
      end
  end

  get "/nonprofits/:slug/projects/closed" do
    @np = Nonprofit.find_by_slug(params[:slug])

    if !@np.nil?
      erb :"nonprofits/closed_projects", :layout => false
    else
      redirect "/nonprofits/failure"
    end
  end

  get "/nonprofits/:slug/projects/edit" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :"nonprofits/edit_projects"
        else
          redirect "/nonprofits/#{current_np.slug}/projects"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post "/nonprofits/:slug/projects/edit" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :"nonprofits/edit_projects"
        else
          redirect "/nonprofits/#{current_np.slug}/projects"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post "/nonprofits/:slug/project/edit" do
    @project = Project.find_by_id(params[:project_id])
    @np = Nonprofit.find_by_slug(params[:slug])
    redirect "/nonprofits/#{@np.slug}/projects/#{@project.id}/edit"
  end

  get "/nonprofits/:slug/projects/delete" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :"nonprofits/delete_projects"
        else
          redirect "/nonprofits/#{current_np.slug}/projects"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post "/nonprofits/:slug/projects/delete" do
    @np = Nonprofit.find_by_slug(params[:slug])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :"nonprofits/delete_projects"
        else
          redirect "/nonprofits/#{current_np.slug}/projects"
        end
      else
        redirect "/nonprofits/#{@np.slug}"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  delete '/developers/:slug/projects/delete' do
    @to_delete = params[:np][:project_ids]

    # #destroy selected projects from Project and its associations
    # #delete merely selects the project from the db and deletes the column, does not destory associations

      @to_delete.each do |p|
        project = Project.find(p)
        project.destroy
      end

      erb :"/nonprofits/edit_projects", locals: {message: "Project(s) successfully removed."} 
  end

  get "/nonprofits/:np_slug/projects/:p_slug" do
    @nonprofit = Nonprofit.find_by_slug(params[:np_slug])
    @project = Project.find_by_slug(params[:p_slug])
    if @project.nil?
      redirect "/projects/failure"
    elsif @nonprofit.nil?
      redirect "/nonprofits/failure"
    else
      erb :"projects/show_project"
    end
  end

  post "/nonprofits/:np_slug/projects/:p_slug" do
    @nonprofit = Nonprofit.find_by_slug(params[:np_slug])
    @project = Project.find_by_slug(params[:p_slug])
    if dev_logged_in?
      if current_dev.projects.include?(@project)
        erb :"projects/show_project", locals: {message: "You have already added this project."}
      else
        current_dev.projects << @project
        erb :"projects/show_project", locals: {message: "Project successfully added."}
      end
    elsif np_logged_in?
      erb :"projects/show_project", locals: {message: "Oops! Only developers can 'take' projects."}
    else
      erb :"projects/show_project", locals: {message: "Please login or sign up."}
    end
  end

  get '/nonprofits/:np_slug/projects/:p_id/edit' do
    @np = Nonprofit.find_by_slug(params[:np_slug])
    @project = Project.find_by_id(params[:p_id])
    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :'/nonprofits/edit_project'
        else
          redirect "/nonprofits/#{current_np.slug}/projects"
        end
      else
        redirect "/nonprofits/#{@np.slug}/projects"
      end
    else
      redirect "/nonprofits/failure"
    end
  end

  post '/nonprofits/:np_slug/projects/:p_id/edit' do
    @np = Nonprofit.find_by_slug(params[:np_slug])
    @project = Project.find_by_id(params[:p_id])
    if current_np.slug == @np.slug
      erb :'/nonprofits/edit_project'
    else
      redirect "/nonprofits/#{current_np.slug}/projects"
    end
  end

  patch '/nonprofits/:np_slug/projects/:p_id/edit' do
    @project = Project.find_by_id(params[:p_id])
    @np = Nonprofit.find_by_slug(params[:np_slug])

    if np_logged_in?
      if current_np.slug == @np.slug
      @project.attributes=(params[:project])
      @project.valid?
        if @project.valid?
          @project.save
          redirect "nonprofits/#{current_np.slug}/projects/#{@project.slug}"
        else
          erb :'nonprofits/edit_project'
        end
      else
      redirect "nonprofits/#{current_np.slug}/projects"
      end
    else
      redirect "nonprofits/all"
    end
  end

end