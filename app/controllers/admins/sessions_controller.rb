class Admins::SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(mail: session_params[:mail])
    if admin && admin.authenticate(session_params[:password])
      log_in(admin)
      redirect_to admins_top_path
    else
      flash.now[:danger] = 'invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to admins_login_path
  end

  private

  def session_params
    params.require(:session).permit(:mail, :password)
  end
end
