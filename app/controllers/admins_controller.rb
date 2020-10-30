class AdminsController < ApplicationController
  def show
    @users = User.all
  end
end
