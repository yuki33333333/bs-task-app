class AdminsController < ApplicationController
  def top
    current_admin
    @users = User.all
  end
end
