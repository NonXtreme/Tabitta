# frozen_string_literal: true

class AnonymousesController < ApplicationController
  def index
    @tweets = Tweet.includes({reply: :user} , :user, :likes).where(user_id: 1).order(created_at: :desc).page params[:page]
  end
end
