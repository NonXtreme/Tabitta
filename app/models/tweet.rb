class Tweet < ApplicationRecord
  after_save :set_hashtag

  validates :content, presence: true, unless: -> { retweet_id.present?;}
  validates :content, length: { maximum: 256}
  paginates_per 5
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :hashtag_tweets, dependent: :destroy
  has_one :retweet, class_name: "Tweet"
  has_one :reply, class_name: "Tweet"

  def set_hashtag
    regex = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    hashtags = content.scan(regex).uniq.flatten
    values=[]
    hashtags.each do |tag|
      unless hashtag = Hashtag.find_by(name:tag)
        hashtag = Hashtag.create(name:tag)
      end
      values << [hashtag.id, id]
    end
    columns = [ :hashtag_id, :tweet_id ]
    HashtagTweet.import columns, values, validate: true
  end
end
