class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_with_token!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
    json_response "Index project successfully", true, {projects: @projects}, :ok
  end

  def show
    @task = @project.tasks.build
    json_response "Show project Successfully", true, {task: @task}, :ok
  end

  def new
    @project = current_user.projects.build
    json_response "new project", true, {project: @project}, :ok
  end

  def edit
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      json_response "Project was successfully created.", true, {project: @project}, :ok
    else
      json_response "Something wrong", false, {}, :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      json_response "Project was successfully updated.", true, {project: @project}, :ok
    else
      json_response "Project was not updated.", false, {}, :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    json_response "Project was successfully destroyed.", true, {}, :no_content
  end

  private
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
