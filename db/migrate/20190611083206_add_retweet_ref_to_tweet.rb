class AddRetweetRefToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :retweet_id, :integer, null: true, index: true
  end
end
