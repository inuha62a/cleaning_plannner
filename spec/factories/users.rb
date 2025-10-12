# spec/factories/users.rb
# モデルごとにファイルを分けるのが一般的
FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { "password" }
      confirmed_at { Time.current }
      global_role { :general }
    end
  end
