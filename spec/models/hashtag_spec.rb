require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'association' do
    it { should have_many(:hashtag_tweets) } 
  end
end
