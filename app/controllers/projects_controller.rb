class ProjectsController < ApplicationController
  get "/projects" do
    erb :"/projects/show_projects"
  end
end