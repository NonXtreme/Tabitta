# frozen_string_literal: true

class Tweets::RetweetsController < ApplicationController
  before_action :authenticate_user!
  def new
    @tweet = Tweet.includes({reply: :user} , :user, :likes).find(params[:tweet_id])
    @retweet = Tweet.new
  end

  def create
    @retweet = Tweet.create(retweet_params)
    if @retweet.valid?
      redirect_to tweets_path
    else
      flash[:fail] = "Tweet #{@retweet.errors.messages[:content].first}"
      redirect_to new_tweet_retweet_path
    end
  end

  private

  def retweet_params
    params.require(:tweet).permit(:content).merge!(retweet_id: params[:tweet_id]).merge!(user_id: current_user.id)
  end
end
