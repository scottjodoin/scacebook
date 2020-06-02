class ChangeFriendshipColumns2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :users_id
    add_reference :friendships, :user, index: true, foreign_key: true

  end
end
