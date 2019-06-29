class SearchController < ApplicationController
  def index
    @options=[:Tweets,:Users]
    if params[:option] == "Users"
      if params[:keyword].present?
        @users = User.where('name ILIKE ? OR email ILIKE ?', "%#{params[:keyword]}%","%#{params[:keyword]}%").page params[:page]
      else
        @users = User.all.page params[:page]
      end
    else
      if params[:keyword].present?
        @tweets = Tweet.includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).where('content ILIKE ?', "%#{params[:keyword]}%").order(created_at: :desc).page params[:page]
      else
        @tweets = Tweet.includes({retweet: [:likes, :user]}, {reply: :user} , :user, :likes).all.order(created_at: :desc).page params[:page]
      end
    end
  end

  private

  def search_params
    params.require(:search).permit(:keyword, :coupon_code)
  end
end
