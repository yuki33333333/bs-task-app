class AdminsController < ApplicationController
  include Admins::SessionsHelper
  def top
    current_admin
    @users = User.all
  end
end
