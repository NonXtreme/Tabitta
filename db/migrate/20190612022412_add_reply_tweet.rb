class AddReplyTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :reply_id, :integer, null: true, index: true
  end
end
