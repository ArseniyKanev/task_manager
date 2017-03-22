class User::TasksController < ApplicationController

  before_action :auth
  load_and_authorize_resource params_method: :task_params

  def index
    @tasks = @tasks.preload(:user).page(page_parameter).load
  end

  def show
  end

  def new
    @users = User.all if current_user.admin?
  end

  def create
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def edit
    @users = User.all if current_user.admin?
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html {render nothing: true}
      format.js {}
    end
  end

  def start
    @task.start!
    respond_to do |format|
      format.html {render nothing: true}
      format.js {}
    end
  end

  def finish
    @task.finish!
    respond_to do |format|
      format.html {render nothing: true}
      format.js {}
    end
  end

  private

  def task_params
    task_params = params.require(:task).permit(:name, :description, :user_id, attachments_attributes: [:file, :id, :_destroy])
    task_params[:user_id] = current_user.id if current_user.user?
    task_params
  end

end
