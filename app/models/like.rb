# frozen_string_literal: true

class Like < ApplicationRecord
  validates :user , uniqueness: { scope: :tweet }
  belongs_to :user
  belongs_to :tweet
end
