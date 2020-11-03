class Admins::SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(mail: session_params[:mail])
    if admin && admin.authenticate(session_params[:password])
      sign_in(admin)
      redirect_to admins_top_path
    else
      flash.now[:danger] = 'invalid email or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to admins_login_path
  end

  private

  def session_params
    params.require(:session).permit(:mail, :password)
  end

  def sign_in(admin)
    remember_token = Admin.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    admin.update!(remember_token: Admin.encrypt(remember_token))
    @current_admin = admin
  end

  def sign_out
    @current_admin = nil
    cookies.delete(:admin_remember_token)
  end

end
