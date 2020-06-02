class ChangeFriendshipColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :sender_id
    remove_column :friendships, :receiver_id
    add_reference :friendships, :users, index: true, foreign_key: true
    add_reference :friendships, :friend, index: true, foreign_key: {to_table: :users}
  end
end