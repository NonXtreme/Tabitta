# frozen_string_literal: true

class Tweets::LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = Like.create(user_id: current_user.id, tweet_id: params[:tweet_id])
    @tweet = Tweet.find_by(id: params[:tweet_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, tweet_id: params[:tweet_id])
    @like.destroy
    @tweet = Tweet.find_by(id: params[:tweet_id])
    respond_to do |format|
      format.js
    end
  end
end
