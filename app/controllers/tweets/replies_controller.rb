# frozen_string_literal: true

class Tweets::RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @reply = Tweet.create(reply_params)
    unless @reply.valid?
      flash[:fail] = "Tweet #{@reply.errors.messages[:content].first}"
    end
    redirect_to tweet_path(params[:tweet_id])
  end

  private

  def reply_params
    if params[:tweet][:tweet_user_id] == '1'
      params.require(:tweet).permit(:content).merge!(reply_id: params[:tweet_id]).merge!(user_id: 1)
    else
      params.require(:tweet).permit(:content).merge!(reply_id: params[:tweet_id]).merge!(user_id: current_user.id)
    end
  end
end
