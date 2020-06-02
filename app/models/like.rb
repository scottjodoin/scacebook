class Like < ApplicationRecord
  belongs_to :user
  belongs_to :polymorphic
end
