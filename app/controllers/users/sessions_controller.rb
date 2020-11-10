class Users::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      user_log_in(user)
      redirect_to tasks_path
    else
      flash.now[:danger] = 'invalid email or password'
      render 'new'
    end
  end

  def destroy
    user_log_out
    redirect_to users_login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def user_log_in(user)
    session[:user_id] = user.id
  end

  def user_log_out
    @current_user = nil
    session.delete(:user_id)
  end
end
