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
end
