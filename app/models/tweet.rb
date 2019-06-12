class Tweet < ApplicationRecord
  validates :content, presence: true, length: { maximum: 256}
  paginates_per 5
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_one :retweet, class_name: "Tweet"
  has_one :reply, class_name: "Tweet"
end
