class SearchController < ApplicationController
  def index
    @options=[:Tweets,:Users]
    if params[:option] == "Users"
      if params[:keyword].present?
        @users = User.where('name ILIKE ? OR email ILIKE ?', "%#{params[:keyword]}%","%#{params[:keyword]}%")
      else
        @users = User.all
      end
    else
      if params[:keyword].present?
        @tweets = Tweet.where('content ILIKE ?', "%#{params[:keyword]}%")
      else
        @tweets = Tweet.all
      end
    end
  end

  private

  def search_params
    params.require(:search).permit(:keyword, :coupon_code)
  end
end
