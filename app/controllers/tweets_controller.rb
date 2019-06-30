# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    if user_signed_in?
      following = Following.where(follower_id: current_user.id).pluck(:followee_id).push(current_user.id)
      @tweets = Tweet.where(user_id: following).includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.all.includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).order(created_at: :desc).page params[:page]
    end
  end

  def create
    @tweet = Tweet.create(tweet_params)
    unless @tweet.valid?
      flash[:fail] = "Tweet #{@tweet.errors.messages[:content].first}"
    end
    redirect_back fallback_location: tweets_path
  end

  def show
    @tweet = Tweet.includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).find_by(id: params[:id])
    if @tweet.present?
      @replies = Tweet.includes(:user, :likes).where(reply_id: params[:id]).order(:created_at).page params[:page]
      @reply = Tweet.new
    else
      redirect_to tweets_path
    end
  end

  def destroy
    @tweet = Tweet.find_by(id: params[:id], user_id: current_user.id)
    @tweet.destroy
    redirect_back fallback_location: tweets_path
  end

  private

  def tweet_params
    if params[:tweet][:anonymously] == '1'
      params.require(:tweet).permit(:content).merge!(user_id: 1)
    else
      params.require(:tweet).permit(:content).merge!(user_id: current_user.id)
    end
  end
end
