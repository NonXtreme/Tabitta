class ApplicationController < ActionController::Base
  before_action :set_hashtags
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_hashtags
    @hashtags = HashtagTweet.joins(:hashtag).group(:hashtag).count.sort_by{|h| h[1]}.reverse
  end

  protected

      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

          devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
      end
end
