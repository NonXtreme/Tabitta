# frozen_string_literal: true

class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.friendly.find(params[:id])
    tweet_ids = HashtagTweet.where(hashtag_id: @hashtag.id).pluck(:tweet_id)
    @tweets = Tweet.where(id: tweet_ids).order(created_at: :desc)
  end
end
