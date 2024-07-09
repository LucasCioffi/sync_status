require 'rails_helper'

RSpec.describe AuthenticateUser do
  describe '#call' do
    let!(:user) { User.create!(email: 'test@example.com', password: 'password123') }

    context 'when valid credentials are provided' do
      it 'returns a token' do
        service = AuthenticateUser.new('test@example.com', 'password123')
        token = service.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials are provided' do
      it 'raises an error' do
        service = AuthenticateUser.new('test@example.com', 'wrong_password')
        expect(service.call).to be_nil
      end
    end
  end
end
