class ApplicationController < ActionController::Base
  before_action :set_hashtags

  def set_hashtags
    @hashtags = Hashtag.group(:name).order(count_all: :desc).count
  end
end
