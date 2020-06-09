class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @display_user = User.find(params[:id])
    if @display_user == current_user
      @status = current_user.statuses.build
      @picture = current_user.pictures.build
    end
    @posts = @display_user.posts
  end

  def index
    @users = User.all
  end
end
