class ApplicationController < ActionController::Base
  before_action :set_hashtags

  def set_hashtags
    @hashtags = HashtagTweet.joins(:hashtag).group(:hashtag).count
  end
end
