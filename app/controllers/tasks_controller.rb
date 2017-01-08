class TasksController < ApplicationController
	def new
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
	end

	def create
  		@task = Task.new(task_params)
      @task.user_id = current_user.id
      if @task.save
  		  redirect_to user_task_path(current_user, @task), :notice => "  task created!"
      else
        redirect_to new_user_task_path ,:alert => " sorry try again :("
      end    
	end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def index
    @user =  User.find(params[:user_id])
    @tasks = @user.tasks.all
  end

  def set_time_tracking
    @task = Task.find(params[:id])
    @task.update_attributes(duration:params[:duration])
    respond_to do |format|
      format.json {render json: @task.duration}
    end
  end
 
private
  def task_params
    params.require(:task).permit(:user_id, :name, :duration, :text)
  end
  
end