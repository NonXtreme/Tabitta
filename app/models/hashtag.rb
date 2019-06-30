# frozen_string_literal: true

class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :hashtag_tweets
end
