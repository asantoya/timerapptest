class TasksController < ApplicationController
	def new
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
	end

	def create
  		@task = Task.new(task_params)
      @task.user_id = current_user.id
      @task.state = 'open'
      if @task.save
        flash[:notice] = "task successfully created"
  		  redirect_to user_task_path(current_user, @task)
      else
        flash[:alert] = "sorry try again :("
        redirect_to new_user_task_path
      end    
	end

  # def create_anonymous

  #   @task = Task.where(:name == 'anonymous')
  #   if @task.nil?
  #     @task = Task.new(task_params)
  #     @task.user_id = current_user.id
  #     @task.name = 'anonymous'
  #     @task.save
  #   else

  #   end
  # end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def index
    @user =  User.find(params[:user_id])
    @tasks = @user.tasks.where(:created_at =>(Time.now - 1.day))
    @tasksToday = @user.tasks.where(:created_at == Time.now)
  end

  def set_time_tracking
    @task = Task.find(params[:id])
    @task.update_attributes(duration:params[:duration],state:params[:state])
    respond_to do |format|
      format.json {render json: @task.duration}
    end
  end

  def set_state_tracking
    @task = Task.find(params[:id])
    @task.update_attributes(,state:params[:state])
    respond_to do |format|
      format.json {render json: @task.duration}
    end
  end  
 
private
  def task_params
    params.require(:task).permit(:user_id, :name, :duration, :text)
  end
  
end