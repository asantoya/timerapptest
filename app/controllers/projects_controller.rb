class ProjectsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @project = @user.projects.build
  end

  def create
      @project = Project.new(project_params)
      @project.user_id = current_user.id
      if @project.save
        flash[:notice] = "task successfully created"
        redirect_to user_project_tasks_path(current_user, @project)
      else
        flash[:alert] = "sorry try again :("
        redirect_to new_user_project_path
      end    
  end

  def show
    @project = Project.find(params[:id])
    @project_tasks = @project.tasks.all
  end

  private
  def project_params
    params.require(:project).permit(:user_id, :name)
  end
end
