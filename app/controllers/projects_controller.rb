class ProjectsController < ApplicationController
  get "/projects" do
    erb :"projects/all_projects"
  end

  get "/:slug/projects/new" do
    @project = Project.new
    @np = Nonprofit.find_by_slug(params[:slug])

    if !@np.nil?
      if np_logged_in?
        if current_np.slug == @np.slug
          erb :"projects/new"
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

  post "/:slug/projects" do
    @project = Project.new(params[:project])
    @project.valid?

    if np_logged_in? && @project.valid?
      @project.nonprofit = current_np
      @project.save
      redirect "nonprofits/#{current_np.slug}/projects/#{@project.slug}"
    else
      erb :"projects/new"
    end
  end

  get "/projects/failure" do
    erb :'projects/failure'
  end

end