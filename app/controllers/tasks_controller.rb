class TasksController < ApplicationController
  include TasksHelper
  include Users::SessionsHelper

  before_action :check_user_login
  before_action :find_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.order(created_at: "DESC")
    @tasks = set_user_tasks(@tasks)
  end

  def show
  end

  def new
    @task = Task.new
    @statuses = Task.statuses.keys
  end

  def create
    @task = Task.new(task_params)
    @task.update_attributes(user_id: session[:user_id])
    @statuses = Task.statuses.keys
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
    @tasks = set_user_tasks(@tasks)
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
    @tasks = set_user_tasks(@tasks)
    render 'index'
  end

  def search
    keyword = params[:keyword]
    @tasks = Task.search(keyword)
    @tasks = set_user_tasks(@tasks)
    render 'index'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :limit, :status)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def set_user_tasks(tasks)
    tasks.where(user_id: session[:user_id])
  end
end
