require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'factory' do
    it 'is valid' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end
end
