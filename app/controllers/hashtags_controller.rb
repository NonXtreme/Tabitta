# frozen_string_literal: true

class HashtagsController < ApplicationController
  def show
    begin
      @hashtag = Hashtag.friendly.find(params[:id])
    rescue
      redirect_to tweets_path
      return
    end
    tweet_ids = HashtagTweet.where(hashtag_id: @hashtag.id).pluck(:tweet_id)
    @tweets = Tweet.includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).where(id: tweet_ids).order(created_at: :desc)
  end
end
