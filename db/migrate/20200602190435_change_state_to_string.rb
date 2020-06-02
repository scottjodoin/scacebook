class ChangeStateToString < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :state
    add_column :friendships, :state, :string, null: false, default: :invited
  end
end
