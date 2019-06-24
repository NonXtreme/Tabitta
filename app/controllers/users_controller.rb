class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @follow = Following.find_by(follower_id:current_user.id, followee_id:params[:id])
  end
end
