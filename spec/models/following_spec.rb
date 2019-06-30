require 'rails_helper'

RSpec.describe Following, type: :model do
  let (:user1){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
  let (:user2){ User.create({:name => "non2", :email => "test2@tests.com", :password => "12345678"}) }
  subject (:valid_follow){ described_class.new(followee: user1, follower: user2) }

  describe 'factory' do
    it 'have valid users' do
      expect(user1).to be_valid
      expect(user2).to be_valid
    end

    it 'has valid follow' do
      expect(valid_follow).to be_valid
    end
  end

  describe 'validations' do

    it 'is invalid if follow is duplicate' do
      valid_follow.save
      follow2 = Following.new(followee: user1, follower: user2)
      expect(follow2).to be_invalid
    end

  end

  describe 'association' do
    it { should belong_to(:follower) } 

    it { should belong_to(:followee) } 
  end

end
