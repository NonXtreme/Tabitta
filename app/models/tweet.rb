class Tweet < ApplicationRecord
  after_save :set_hashtag

  validates :content, presence: true, unless: -> { retweet_id.present?;}
  validates :content, length: { maximum: 256}
  paginates_per 5
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_one :retweet, class_name: "Tweet"
  has_one :reply, class_name: "Tweet"

  def set_hashtag
    regex = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    values = content.scan(regex).uniq.map{|h| h << id }
    columns = [ :name, :tweet_id ]
    Hashtag.import columns, values, validate: true
  end
end
