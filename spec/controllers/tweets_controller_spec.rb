require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
    let (:user1){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
    let (:user2){ User.create({:name => "non2", :email => "test2@tests.com", :password => "12345678"}) }
    let (:user3){ User.create({:name => "non3", :email => "test3@tests.com", :password => "12345678"}) }
    describe '#index' do
        it "assigns all tweets to @tweets if not signed in" do
            tweet1 = Tweet.create(user:user1,content:"Tweet 1")
            tweet2 = Tweet.create(user:user1,content:"Tweet 2")
            get :index
            expect(assigns(:tweets)).to include(tweet1,tweet2)
            expect(assigns(:tweets).size).to eq(2)
        end

        it "assigns only followee's tweets to @tweets if signed in" do
            tweet1 = Tweet.create(user:user1,content:"Tweet 1")
            tweet2 = Tweet.create(user:user2,content:"Tweet 2")
            tweet3 = Tweet.create(user:user3,content:"Tweet 3")
            Following.create(followee: user1, follower: user2)
            subject.sign_in user2
            get :index
            expect(assigns(:tweets)).to include(tweet1,tweet2)
            expect(assigns(:tweets)).not_to include(tweet3)
            expect(assigns(:tweets).size).to eq(2)
        end

        it "assign @tweets to included signed in user's tweets" do
            tweet1 = Tweet.create(user:user1,content:"Tweet 1")
            subject.sign_in user1
            get :index
            expect(assigns(:tweets)).to include(tweet1)
        end
    end

    describe '#create' do
        it 'redirect to signed in page if not signed in' do
            response = post :create
            expect(response).to redirect_to(new_user_session_path)
        end

        it 'create new tweet if signed in' do
            subject.sign_in user1
            expect{post :create, :params => {:tweet => {content:"new tweet", anonymously:0}}}.to change{Tweet.count}.by(1)
        end
    end

    describe '#show' do
        it 'redirect to #index page if tweet not present' do
            tweet = Tweet.create(user: user1, content: "A tweet")
            tweet.destroy
            response = get :show, :params=>{id: tweet.id}
            expect(response).to redirect_to(tweets_path)
        end
    end

    describe '#destroy' do
        it 'redirect to signed in page if not signed in' do
            response = post :destroy, :params => {:id => 321}
            expect(response).to redirect_to(new_user_session_path)
        end
        
        it 'create destroy tweet if signed in' do
            subject.sign_in user1
            tweet = Tweet.create(user: user1, content: "A tweet")
            expect{post :destroy, :params => {:id => tweet.id}}.to change{Tweet.count}.by(-1)
        end
    end

end
