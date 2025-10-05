# db/seeds.rb

User.destroy_all
Location.destroy_all
Task.destroy_all

user = User.create!(
  email: 'test@example.com',
  password: 'password',
  confirmed_at: Time.current,
  system_role: :general
)

location = Location.create!(
  name: '玄関',
  user: user,
  group: nil
)

task = Task.create!(
  name: 'ほうきで掃く',
  user: user,
  location: location,
  status: :pending,
  frequency: :weekly,
  last_done_at: 5.days.ago
)
