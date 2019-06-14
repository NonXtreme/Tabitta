class ApplicationController < ActionController::Base
  before_action :set_hashtags

  def set_hashtags
    @hashtags = HashtagTweet.joins(:hashtag).group(:hashtag).count.sort_by{|h| h[1]}.reverse
  end
end
