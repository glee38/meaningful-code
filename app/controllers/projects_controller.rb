class ProjectsController < ApplicationController
  get "/projects" do
    erb :"projects/all_projects"
  end

  get "/projects/new" do
    @project = Project.new
    if np_logged_in?
      erb :"projects/new"
    else
      redirect "/"
    end
  end

  post "/projects" do
    @project = Project.new(params)
    @project.valid?

    if np_logged_in? && @project.valid?
      @project.nonprofit = current_np
      @project.save
      redirect "nonprofits/#{current_np.slug}/projects/#{@project.slug}"
    else
      erb :"projects/new"
    end
  end

end