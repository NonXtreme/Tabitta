class CreateHashtagTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_tweets do |t|
      t.references :hashtag, index: true
      t.references :tweet, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
    
  end
end
