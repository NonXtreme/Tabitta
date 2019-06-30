require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let (:user){ User.create({:name => "non", :email => "test@tests.com", :password => "12345678"}) }
    describe '#show' do
        
        it "assigns the requested user to @user" do
            get :show, params:{id:user.id}
            expect(assigns(:user)).to eq(user)
        end
        it "assigns the requested user's tweets to @tweets" do
            tweet=Tweet.create(user:user, content:"test")
            subject.sign_in user
            get :show, params:{id:user.id}
            expect(assigns(:tweets)).to eq([tweet])
        end
        it "assigns the current user follow record of the requested user to @follow" do
            user
            follower = User.create({:name => "non2", :email => "test2@tests.com", :password => "12345678"})
            follow = Following.create(followee:user,follower:follower)
            subject.sign_in follower
            get :show, params:{id:user.id}
            expect(assigns(:follow)).to eq(follow)
        end
    end

end
