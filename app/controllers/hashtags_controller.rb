class HashtagsController < ApplicationController

  def show
    @hashtag = Hashtag.where(params[:id])
  end

end
