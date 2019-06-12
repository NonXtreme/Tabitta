class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets=Tweet.all.order(created_at: :desc).page params[:page]
  end

  def create
    @tweet=Tweet.create(tweet_params)
    unless @tweet.valid?
      flash[:fail] = "Tweet #{@tweet.errors.messages[:content][0]}"
    end
    redirect_to action: :index
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.present?
      @replies = Tweet.where(reply_id: params[:id])
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
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content).merge!(user_id: current_user.id)
  end
end
