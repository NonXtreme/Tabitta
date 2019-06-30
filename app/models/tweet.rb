# frozen_string_literal: true

class Tweet < ApplicationRecord
  after_save :set_hashtag

  validates :content, presence: true, unless: -> { retweet_id.present?; }
  validates :content, length: { maximum: 256 }
  paginates_per 10
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :hashtag_tweets, dependent: :destroy
  has_many :hashtags, through: :hashtag_tweets
  belongs_to :retweet, class_name: 'Tweet', optional: true
  belongs_to :reply, class_name: 'Tweet', optional: true

  def set_hashtag
    regex = /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
    hashtags = content.scan(regex).flatten.uniq(&:downcase)
    values = []
    hashtags.each do |tag|
      unless hashtag = Hashtag.find_by('LOWER(name)= ?', tag.downcase)
        hashtag = Hashtag.create(name: tag)
      end
      values << [hashtag.id, id]
    end
    columns = %i[hashtag_id tweet_id]
    HashtagTweet.import columns, values, validate: true
  end
end
