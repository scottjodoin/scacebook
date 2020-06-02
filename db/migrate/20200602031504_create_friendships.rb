class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :sender, index: true, foreign_key: {to_table: :users}
      t.references :receiver, index: true, foreign_key: {to_table: :users}
      t.integer :state

      t.timestamps
    end
  end
end
