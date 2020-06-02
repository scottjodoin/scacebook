class Picture < ApplicationRecord
  # string:description
  has_one_attached :image
  has_many :likes, as: :likeable
  alias_attribute :likers, :users
  has_many :users, through: :likes
  belongs_to :album
  belongs_to :user, through: :album
end
