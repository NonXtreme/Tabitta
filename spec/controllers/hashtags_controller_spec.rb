require 'rails_helper'

RSpec.describe HashtagsController, type: :controller do
  let (:user1){ User.create({:name => "non", :email => "non@tests.com", :password => "12345678"}) }
  let (:user2){ User.create({:name => "John", :email => "john@tests.com", :password => "12345678"}) }
  
  describe '#show' do
    it "assigns tweets of the hashtag to @tweets" do
      tweet1 = Tweet.create(user:user1,content:"Tweet 1 #hashtag")
      tweet2 = Tweet.create(user:user2,content:"Tweet 2 #hashtag")
      get :show, :params => {id:"hashtag"}
      expect(assigns(:tweets)).to include(tweet1,tweet2)
      expect(assigns(:tweets).size).to eq(2)
    end

    it "assigns hashtag of the hashtag to @hashtag" do
      tweet1 = Tweet.create(user:user1,content:"Tweet 1 #hashtag")
      tweet2 = Tweet.create(user:user2,content:"Tweet 2 #hashtag")
      get :show, :params => {id:"hashtag"}
      expect(assigns(:hashtag).name).to eq("hashtag")
    end
  end
end
