require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let (:user1){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
  let (:user2){ User.create({:name => "non2", :email => "test2@tests.com", :password => "12345678"}) }
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

  end
end
