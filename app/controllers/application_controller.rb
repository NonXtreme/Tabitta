# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_hashtags, :set_suggestions
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_hashtags
    @hashtags = HashtagTweet.joins(:hashtag).group(:hashtag).order('count_all desc').limit(5).count
  end

  def set_suggestions
    if user_signed_in?
      suggest_user_ids=Following.where(followee_id:current_user.followee_ids).group(:follower_id).limit(5).order('count_all desc').count.keys - [current_user.id] - current_user.followee_ids
      @suggested_users=User.where(id:suggest_user_ids)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
