Rails.application.routes.draw do
  post '/authenticate', to: 'sessions#create'
  get '/meetings/:meeting_id/sync_status', to: 'meetings#sync_status'
  get '/meetings/:meeting_id/last_sync_success', to: 'meetings#last_sync_success'
end
