require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:valid_user) do
    create(:user)
  end

  describe 'valid factories' do
    it 'is valid' do
      expect(valid_user).to be_valid
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'association' do
    it { should have_many(:tweets).dependent(:destroy) } 

    it { should have_many(:likes).dependent(:destroy) } 
    
    it { should have_many(:followee_ids).dependent(:destroy) } 

    it { should have_many(:followees).through(:followee_ids) } 

    it { should have_many(:follower_ids).dependent(:destroy) } 

    it { should have_many(:followers).through(:follower_ids) } 

  end

end
