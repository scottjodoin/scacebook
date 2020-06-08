class Status < ApplicationRecord
  # string:body
  belongs_to :user
  alias_attribute :likers, :users
  has_many :users, through: :likes
  has_many :posts, as: :postable
end
