class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    set_likeable
    current_user.likes.create(
      likeable_id: @likeable.id,
      likeable_type: @likeable.class.name
      )
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    return unless @like.user == current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def set_likeable
    @klass = like_params[:likeable_type].capitalize.constantize
    @likeable = @klass.find(like_params[:likeable_id])
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end