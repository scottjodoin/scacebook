class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def send_request

    friend_id = friendship_params[:friend_id]
    raise "Unfriend error" unless current_user.id != friend_id and
    User.exists?(friend_id)

    new_friend = User.find(friendship_params[:friend_id])
    f = Friendship.new(user: current_user, friend: new_friend, state: :accepted)
    f_i = Friendship.new(user: new_friend, friend: current_user, state: :invited)
    Friendship.transaction do
      f.save!
      f_i.save!
    end

    redirect_back(fallback_location: root_path)
  end

  def accept_request
    friend_id = friendship_params[:friend_id]
    raise "Unfriend error" unless current_user.id != friend_id and
    User.exists?(friend_id)

    Friendship.where(user_id: current_user, friend_id: friend_id ).first.update(state: "accepted")

    redirect_back(fallback_location: root_path)
  end

  def unfriend
    friend_id = friendship_params[:friend_id]
    raise "Unfriend error" unless current_user.id != friend_id and
    User.exists?(friend_id)

    Friendship.where(user_id: current_user, friend_id: friend_id).or(
      Friendship.where(user_id: friend_id, friend_id: current_user)).destroy_all

    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
