require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let (:user1){ User.create({:name => "non", :email => "non@tests.com", :password => "12345678"}) }
  let (:user2){ User.create({:name => "John", :email => "john@tests.com", :password => "12345678"}) }
  describe '#index' do
    it "assigns all tweets to @tweets if doesn't enter keyword" do
      tweet1 = Tweet.create(user:user1,content:"Tweet 1")
      tweet2 = Tweet.create(user:user2,content:"Tweet 2")
      get :index
      expect(assigns(:tweets)).to include(tweet1,tweet2)
      expect(assigns(:tweets).size).to eq(2)
    end

    it "assigns all users to @users if doesn't enter keyword and select users option" do
      user1
      user2
      get :index, :params => {option:"Users"}
      expect(assigns(:users)).to include(user1,user2)
      expect(assigns(:users).size).to eq(2)
    end

    it "search tweets correctly" do
      tweet1 = Tweet.create(user:user1,content:"First Tweets")
      tweet2 = Tweet.create(user:user2,content:"Hello")
      get :index, :params => {option:"Tweets", keyword:"Hell"}
      expect(assigns(:tweets)).to include(tweet2)
      expect(assigns(:tweets)).not_to include(tweet1)
    end

    it "search users correctly" do
      user1
      user2
      get :index, :params => {option:"Users", keyword:"non"}
      expect(assigns(:users)).to include(user1)
      expect(assigns(:users)).not_to include(user2)
    end

  end
end
