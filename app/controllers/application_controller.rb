class ApplicationController < ActionController::Base

  before_action :current_admin
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception

  def current_admin
    remember_token = Admin.encrypt(cookies[:admin_remember_token])
    @current_admin ||= Admin.find_by(remember_token: remember_token)
  end

  def sign_in(admin)
    remember_token = Admin.new_remember_token
    cookies.permanent[:admin_remember_token] = remember_token
    admin.update!(remember_token: Admin.encrypt(remember_token))
    @current_admin = admin
  end

  def sign_out
    @current_admin = nil
    cookies.delete(:admin_remember_token)
  end

  def signed_in?
    @current_admin.present?
  end

  private

  def require_sign_in!
    redirect_to login_path unless signed_in?
  end
end
