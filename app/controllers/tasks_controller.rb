class TasksController < ApplicationController
  include TasksHelper

  before_action :find_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all
              .order(created_at: "DESC")
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

  def search
    selection = params[:keyword]
    unless SORT_OPTION_ARRAY.include?(selection)
      render(:index, status: :bad_request)
      return
    end

    @tasks = Task.sort(selection)
    render 'index'
  end

  private

    def task_params
      params.require(:task).permit(:name, :description, :limit)
    end

    def find_task
      @task = Task.find(params[:id])
    end
end
