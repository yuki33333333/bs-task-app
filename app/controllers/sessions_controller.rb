class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_admin, only: [:create]

  def new
  end

  def create
    if @admin.authenticate(session_params[:password])
      sign_in(@admin)
      redirect_to tasks_path
    else
      flash.now[:danger] = 'invalid password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def set_admin
    @admin = Admin.find_by!(mail: session_params[:mail])
  rescue
    flash.now[:danger] = 'invalid email'
    render 'new'
  end

  def session_params
    params.require(:session).permit(:mail, :password)
  end
end
