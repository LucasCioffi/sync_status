FactoryBot.define do
  factory :meeting do
    user { nil }
    title { "MyString" }
    in_progress_sync_status { 1 }
    last_sync_success { false }
    last_sync_at { "2024-07-09 13:26:24" }
  end
end
