require 'rails_helper'

RSpec.describe Like, type: :model do
  let (:user){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
  let (:tweet){ Tweet.create({:content => "A tweet", :user_id => user.id, }) }
  subject (:valid_like){ described_class.new(user: user, tweet: tweet) }

  describe 'factory' do
    it 'has a valid user' do
      expect(user).to be_valid
    end

    it 'has a valid tweet' do
      expect(tweet).to be_valid
    end

    it 'has valid like' do
      expect(valid_like).to be_valid
    end
  end

  describe 'validations' do

    it 'is invalid if like is duplicate' do
      valid_like.save
      like2 = Like.new(user: user, tweet: tweet)
      expect(like2).to be_invalid
    end

  end

  describe 'association' do
    it { should belong_to(:user) } 

    it { should belong_to(:tweet) } 
  end

end
