class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task deleted"
    redirect_to tasks_path
  end
  private

    def task_params
      params.require(:task).permit(:name, :description)
    end
end
