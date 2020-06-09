class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_postable, only: [:edit]
  before_action :set_post, only: [:show, :edit, :destroy]
  
  def show
    #@postable contains class
  end

  def new
    @status = current_user.statuses.build
    @picture = current_user.pictures.build
  end

  def edit
    helper_function = "edit_#{@postable.class.name.downcase}_path" 
    puts helper_function
    redirect_to send(helper_function, @postable)
  end

  def destroy
    unless current_user == @post.user
      redirect_to root_path
      return
    end
    @post.postable.destroy if @post.user == current_user and !@post.postable.nil? 
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Post was successfully deleted.' }
    end
  end

  def index
    set_user
    redirect_to @user
  end

  private

  def find_postable
    if params[:postable_type].nil?
      redirect_to root_path
      return
    end
    @klass = params[:postable_type].capitalize.constantize
    @postable = @klass.find(params[:postable_id])
  end

  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound => es
      @user = current_user
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end

end