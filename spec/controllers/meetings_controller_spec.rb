# These tests are still pending


# require 'rails_helper'

# RSpec.describe MeetingsController, type: :controller do
#   let(:user) { create(:user) }
#   let(:meeting) { create(:meeting, user: user) }

#   before do
#     sign_in user # Assuming a helper method `sign_in` to sign in the user
#   end

#   describe 'GET #sync_status' do
#     context 'when authorized' do
#       it 'returns in_progress_sync_status' do
#         get :sync_status, params: { meeting_id: meeting.id }
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)).to have_key('in_progress_sync_status')
#       end
#     end

#     context 'when unauthorized' do
#       it 'returns unauthorized error' do
#         other_user = create(:user)
#         meeting.update(user: other_user)

#         get :sync_status, params: { meeting_id: meeting.id }
#         expect(response).to have_http_status(:unauthorized)
#         expect(JSON.parse(response.body)['error']).to eq('Unauthorized')
#       end
#     end

#     context 'when meeting not found' do
#       it 'returns not found error' do
#         get :sync_status, params: { meeting_id: 'invalid_id' }
#         expect(response).to have_http_status(:not_found)
#         expect(JSON.parse(response.body)['error']).to eq('Not found')
#       end
#     end
#   end

#   describe 'GET #last_sync_success' do
#     context 'when authorized' do
#       it 'returns last_sync_success' do
#         get :last_sync_success, params: { meeting_id: meeting.id }
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)).to have_key('last_sync_success')
#       end
#     end

#     context 'when unauthorized' do
#       it 'returns unauthorized error' do
#         other_user = create(:user)
#         meeting.update(user: other_user)

#         get :last_sync_success, params: { meeting_id: meeting.id }
#         expect(response).to have_http_status(:unauthorized)
#         expect(JSON.parse(response.body)['error']).to eq('Unauthorized')
#       end
#     end

#     context 'when meeting not found' do
#       it 'returns not found error' do
#         get :last_sync_success, params: { meeting_id: 'invalid_id' }
#         expect(response).to have_http_status(:not_found)
#         expect(JSON.parse(response.body)['error']).to eq('Not found')
#       end
#     end
#   end
# end
