# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
  has_many :followee_ids, class_name:  "Following",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :followees, through: :followee_ids
  has_many :follower_ids, class_name:  "Following",
                                  foreign_key: "followee_id",
                                  dependent:   :destroy
  has_many :followers, through: :follower_ids
end
