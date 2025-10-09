FactoryBot.define do
    factory :task do
      association :user
      association :location
      title { "テスト掃除" }
      frequency { :weekly }
      last_done_at { 3.days.ago }
      status { :pending }
    end
  end
  