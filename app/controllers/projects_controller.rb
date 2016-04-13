class ProjectsController < ApplicationController
  get "/projects" do
    erb :"projects/show_projects"
  end

  get "/projects/new" do
    erb :"projects/new"
  end
end