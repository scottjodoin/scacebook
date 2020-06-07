class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    Friendship.where(user_id: current_user).or(
      Friendship.where(friend_id: current_user)).destroy_all
    super
  end
end