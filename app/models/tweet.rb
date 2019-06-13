class Tweet < ApplicationRecord
  validates :content, presence: true, unless: -> { retweet_id.present?;}
  validates :content, length: { maximum: 256}
  paginates_per 5
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_one :retweet, class_name: "Tweet"
  has_one :reply, class_name: "Tweet"
end
