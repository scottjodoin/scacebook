class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @display_user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
