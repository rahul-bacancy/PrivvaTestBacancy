class IssuesController < ApplicationController
  before_action :authenticate_with_token!
  before_action :set_project
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    @issues = @project.issues
    json_response "Index issue successfully", true, {issues: @issues}, :ok
  end

  def show
  end

  def new
    @issue = @project.issues.build
    json_response "new issue", true, {issue: @issue}, :ok
  end

  def edit
  end

  def create
    @issue = @project.issues.build(issue_params)
    if @issue.save
      json_response "Issue was successfully created.", true, {issue: @issue}, :ok
    else
      json_response "Something wrong", false, {}, :unprocessable_entity
    end
  end

  def update
    if @issue.update_attributes(issue_params)
      json_response "Issue was successfully updated.", true, {issue: @issue}, :ok
    else
      json_response "Issue was not updated.", false, {}, :unprocessable_entity
    end
  end

  def destroy
    @issue.destroy
    json_response "Issue was successfully destroyed.", true, {}, :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    def set_issue
      @issue = @project.issues.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(:name, :description, :status, :project_id)
    end
end
