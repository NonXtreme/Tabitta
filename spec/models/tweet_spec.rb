require 'rails_helper'

RSpec.describe Tweet, type: :model do
  # subject(:valid_tweet) do
  #   create(:tweet)
  # end

  # describe 'valid factories' do
  #   it 'is valid' do
  #     expect(valid_user).to be_valid
  #   end
  # end

  describe 'validations' do
    it 'is valid without a content if it is a retweet' do
      user = User.create({:name => "non", :email => "test@tests.com", :password => "12345678"})
      tweet = Tweet.create({:content => "Hello", :user_id => user.id, })
      retweet = Tweet.create({:content => "", :user_id => user.id, :retweet_id => tweet.id })
      expect(retweet).to be_valid
    end
    it 'is invalid without a content if it is not a retweet' do
      user = User.create({:name => "non", :email => "test@tests.com", :password => "12345678"})
      tweet = Tweet.create({:content => "", :user_id => user.id, })
      expect(tweet).to be_invalid
    end
  end
end
