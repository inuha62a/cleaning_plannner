# spec/factories/task_histories.rb
FactoryBot.define do
  factory :task_history do
    association :task
    association :user
    done_at { Time.current }
    status_before { :pending }
    status_after { :done }
    source { :manual }
    note { "完了しました" }
  end
end
