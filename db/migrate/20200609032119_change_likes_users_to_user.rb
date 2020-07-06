class ChangeLikesUsersToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :users_id
    add_reference :likes, :user, foreign_key: true, index: :true
  end
end
