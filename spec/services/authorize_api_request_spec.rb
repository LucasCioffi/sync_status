require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  describe '#call' do
    let(:user) { create(:user) }
    let(:headers) { { 'Authorization' => "Bearer #{JsonWebToken.encode(user_id: user.id)}" } }

    context 'when a valid token is provided' do
      it 'returns the user' do
        service = AuthorizeApiRequest.new(headers)
        expect(service.call).to eq(user)
      end
    end

    context 'when an invalid token is provided' do
      it 'returns nil' do
        headers['Authorization'] = 'Invalid Token'
        service = AuthorizeApiRequest.new(headers)
        expect(service.call).to be_nil
      end
    end

    context 'when no token is provided' do
      it 'returns nil' do
        headers['Authorization'] = nil
        service = AuthorizeApiRequest.new(headers)
        expect(service.call).to be_nil
      end
    end
  end
end
