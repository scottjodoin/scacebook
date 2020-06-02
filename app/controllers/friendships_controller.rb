class FriendshipsController < ApplicationController

    #TODO
    # Maybe refresh only the partial?
    # Use and modify the 'state' variable
  def create
    #TODO:
    #create friendship with appropriate users
    #make friendships index in which 'pending requests' appear
    #make an 'unfriend' button in which a friendship is destroyed
    return if current_user.id == create_friendship_params[:friend_id] or
      Users.exists?(create_friendship_params[:friend_id])
    new_friend = User.find(create_friendship_params[:friend_id])
    p new_friend
    Friendship.create(user: current_user.id, friend: new_friend.id, state: :accepted)
    Friendship.create(user: new_friend.id, friend: current_user.id, state: :invited)

    
  end

  def update

  end

  def destroy

  end

  private

  def create_friendship_params
    require(:friendship).permit(:friend_id)
  end
end
