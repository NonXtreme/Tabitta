# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_hashtags, :set_suggestions

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_hashtags
    @hashtags = HashtagTweet.joins(:hashtag).group(:hashtag).order('count_all desc').limit(5).count
  end

  def set_suggestions
    if user_signed_in?
      suggestion_limit = 5
      suggest_user_ids = Following.where(followee_id:current_user.followee_ids).group(:follower_id).limit(suggestion_limit).order('count_all desc').count.keys - [current_user.id] - current_user.followee_ids - [1]
      @suggested_users = User.where(id:suggest_user_ids)
      @suggested_users += Following.joins(:followee).where.not(followee_id:suggest_user_ids + [current_user.id] + current_user.followee_ids + [1]).group(:followee).order('count_all desc').limit(suggestion_limit-@suggested_users.size).count.keys if @suggested_users.size < suggestion_limit
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
