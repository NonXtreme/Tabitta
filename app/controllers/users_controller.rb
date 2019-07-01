# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.includes(:followees, :followers).find_by(id: params[:id])
    unless @user.present?
      redirect_to tweets_path
      return
    end
    @tweets = @user.tweets.includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).order(created_at: :desc).page params[:page]
    @follow = Following.find_by(follower_id: current_user&.id, followee_id: params[:id])
  end

  def followers
    @user = User.includes(:followers).find_by(id: params[:user_id])
    unless @user.present?
      redirect_to tweets_path
      return
    end
    @followers = @user.followers
  end

  def followees
    @user = User.includes(:followees).find_by(id: params[:user_id])
    unless @user.present?
      redirect_to tweets_path
      return
    end
    @followees = @user.followees
  end
end
