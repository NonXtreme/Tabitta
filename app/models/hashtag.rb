# frozen_string_literal: true

class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name , :uniqueness => { :case_sensitive => false } , presence: true
  has_many :hashtag_tweets
end
