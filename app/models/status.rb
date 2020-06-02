class Status < ApplicationRecord
  # string:body
  alias_attribute :likers, :users
  has_many :users, through: :likes
end
