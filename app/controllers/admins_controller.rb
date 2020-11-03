class AdminsController < ApplicationController
  def top
    current_admin
    @users = User.all
  end

  private

  def current_admin
    remember_token = Admin.encrypt(cookies[:remember_token])
    @current_admin ||= Admin.find_by(remember_token: remember_token)
  end
end
