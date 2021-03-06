class User < ApplicationRecord

  before_destroy :destroy_friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  # friends       
  has_many :friendships
  has_many :friends, class_name: "User", through: :friendships, dependent: :destroy

  # assets
  has_many :pictures
  has_many :statuses

  # posts
  has_many :posts
  
  # likes
  has_many :likes

  # profile
  has_one_attached :image

  def friendship_state(friend)
    # expects friend: a user
    return :none unless friends.exists?(friend.id)
    f_state = Friendship.where(user_id: id, friend_id: friend.id).first.state
    f_i_state = Friendship.where(user_id: friend.id, friend_id: id).first.state

    if f_state == "accepted" and f_i_state == "accepted"
      return :accepted
    elsif f_state == "accepted" and f_i_state == "invited"
      return :sent
    elsif f_state == "invited" and f_i_state == "accepted"
      return :pending_acceptance
    end

    return :none
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end


  private
  def destroy_friendships
    friendships.each do |friendship|
      friendship.destroy
    end
  end
end
