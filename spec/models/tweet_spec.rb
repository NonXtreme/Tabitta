require 'rails_helper'

RSpec.describe Tweet, type: :model do

  let (:user){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
  subject (:valid_tweet){ described_class.create({:content => "A tweet", :user_id => user.id, }) }
  subject (:valid_retweet){ described_class.create({:content => "A retweet", :user_id => user.id, :retweet_id => valid_tweet.id }) }
  subject (:valid_reply){ described_class.create({:content => "A reply", :user_id => user.id, :reply_id => valid_tweet.id}) }

  describe 'validations' do
    it 'has a valid user' do
      expect(user).to be_valid
    end

    it 'is a valid tweet' do
      expect(valid_tweet).to be_valid
    end

    it 'has a valid retweet' do
      expect(valid_retweet).to be_valid
    end

    it 'has a valid reply' do
      expect(valid_reply).to be_valid
    end

    it 'is valid without a content if it is a retweet' do
      valid_retweet.content=""
      expect(valid_retweet).to be_valid
    end

    it 'is invalid without a content if it is not a retweet' do
      valid_tweet.content = ""
      expect(valid_tweet).to be_invalid
    end

    it 'is invalid if content is longer than 256' do
      valid_tweet.content = "a"*257
      expect(valid_tweet).to be_invalid
      valid_retweet.content = "a"*257
      expect(valid_retweet).to be_invalid
      valid_reply.content = "a"*257
      expect(valid_reply).to be_invalid
    end
  end

  describe 'association' do
    it { should belong_to(:user) } 

    it { should have_many(:likes).dependent(:destroy) } 

    it { should have_many(:hashtag_tweets).dependent(:destroy) } 
    
    it { should have_many(:hashtags).dependent(:destroy) } 

    it { should belong_to(:retweet).optional() } 

    it { should belong_to(:reply).optional() } 

  end

  describe 'hashtag' do
    it "triggers set_hashtag on save" do
      expect(valid_tweet).to receive(:set_hashtag)
      valid_tweet.content = "tweet with #hashtag"
      valid_tweet.save
    end

    it "set_hashtag should parse hashtag correctly" do
      valid_tweet.content = "tweet with #ARandomHashtag"
      valid_tweet.save
      expect(Hashtag.last.name).to eq("ARandomHashtag")
    end

    it "set_hashtag should be able to parse multiple hashtags" do
      valid_tweet.content = "tweet with #Hashtag1 #Hashtag2"
      valid_tweet.save
      expect(Hashtag.count).to eq(2)
    end

    it "set_hashtag should ignore duplicate hashtags" do
      valid_tweet.content = "tweet with #ARandomHashtag #ARandomHashtag"
      valid_tweet.save
      expect(HashtagTweet.count).to eq(1)
    end

  end
end
