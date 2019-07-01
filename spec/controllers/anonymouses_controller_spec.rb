require 'rails_helper'

RSpec.describe AnonymousesController, type: :controller do
  let (:anon){ User.create({:name => "Anonymous", :email => "anon@anon.com", :password => "12345678"}) }
  let (:user){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
  describe '#index' do
    it "assigns the anon tweets to @tweets" do
      tweet=Tweet.create(user:anon, content:"test")
      tweet2=Tweet.create(user:user, content:"test2")
      get :index
      expect(assigns(:tweets)).to eq([tweet])
    end
  end
end
