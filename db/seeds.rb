# db/seeds.rb

# 依存関係の深い順に削除(子→親の順に削除が鉄則)
Task.destroy_all
Location.destroy_all
User.destroy_all

# データ作成
user = User.create!(
  email: 'test@example.com',
  password: 'password',
  confirmed_at: Time.current,
  global_role: :general
)

location = Location.create!(
  name: '玄関',
  user: user,
  group: nil
)

task = Task.create!(
  title: 'ほうきで掃く',
  user: user,
  location: location,
  status: :pending,
  frequency: :weekly,
  last_done_at: 5.days.ago
)
