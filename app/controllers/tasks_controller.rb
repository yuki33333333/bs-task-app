class TasksController < ApplicationController
  before_action :find_task, only: %i(show edit update destroy)
  def index
    @tasks = Task.all
  end

  def show
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Task created"
      redirect_to @task
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Task deleted"
    redirect_to tasks_path
  end
  private

    def task_params
      params.require(:task).permit(:name, :description)
    end

    def find_task
      @task = Task.find(params[:id])
    end
end
