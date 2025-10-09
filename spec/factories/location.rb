# spec/factories/locations.rb
FactoryBot.define do
    factory :location do
      name { "玄関" }
      association :user
      group { nil }
    end
  end
  