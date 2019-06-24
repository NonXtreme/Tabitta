class AddFollowerToFollowings < ActiveRecord::Migration[5.2]
  def change
    add_column :followings, :follower_id, :integer, null: false, index: true
    add_column :followings, :followee_id, :integer, null: false, index: true
    add_index :followings, [:follower_id, :followee_id], unique: true
  end
end
