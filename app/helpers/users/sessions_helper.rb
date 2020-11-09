module Users::SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def check_signin
    require_signin unless signed_in?
  end

  def require_signin
    redirect_to users_signin_path
  end
end
