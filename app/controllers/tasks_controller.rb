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
    @statuses = Task.statuses.keys
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
    @statuses = Task.statuses.keys
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

  def sort
    option = params[:sort_option]
    unless SORT_OPTION_ARRAY.include?(option)
      render(:index, status: :bad_request)
      return
    end

    @tasks = Task.sort(option)
    render 'index'
  end

  def filter
    option = params[:filter_option]
    statuses = Task.statuses.keys
    unless statuses.include?(option)
      render(:index, status: :bad_request)
      return
    end

    @tasks = Task.filter(option)
    render 'index'
  end

  def search
    keyword = params[:keyword]
    @tasks = Task.search(keyword)
    render 'index'
  end

  private

    def task_params
      params.require(:task).permit(:name, :description, :limit, :status)
    end

    def find_task
      @task = Task.find(params[:id])
    end
end
