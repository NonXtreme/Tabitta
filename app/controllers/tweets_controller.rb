class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if user_signed_in?
      following=Following.where(follower_id:current_user.id).map(&:followee_id).push(current_user.id)
      @tweets = Tweet.where(user_id:following).order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.all.order(created_at: :desc).page params[:page]
    end
  end

  def create
    @tweet=Tweet.create(tweet_params)
    unless @tweet.valid?
      flash[:fail] = "Tweet #{@tweet.errors.messages[:content][0]}"
    end
    redirect_back fallback_location: tweets_path
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.present?
      @replies = Tweet.where(reply_id: params[:id]).order(:created_at)
      @reply = Tweet.new
      if @has_retweet=@tweet.retweet_id.present?
        @retweet = Tweet.find_by(id: @tweet.retweet_id)
      else
        @retweet = nil
      end
    end
  end

  def destroy
    @tweet=Tweet.find_by(id: params[:id],user_id: current_user.id)
    @tweet.destroy
    redirect_back fallback_location: tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content).merge!(user_id: current_user.id)
  end
end
