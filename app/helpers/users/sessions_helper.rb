module Users::SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    !current_user.nil?
  end

  def check_user_login
    require_user_login unless user_logged_in?
  end

  def require_user_login
    redirect_to users_login_path
  end
end
