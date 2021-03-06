# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  before_action :authenticate_user!
  def create
    Following.create(follower_id: current_user.id, followee_id: params[:user_id])
    redirect_back fallback_location: tweets_path
  end

  def destroy
    @following = Following.find_by(follower_id: current_user.id, followee_id: params[:user_id])
    @following.destroy
    redirect_back fallback_location: tweets_path
  end
end
