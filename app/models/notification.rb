class Notification < ApplicationRecord
  belongs_to :task
  belongs_to :user

  enum :method, { line: 0, email: 1, in_app: 2 }
end
