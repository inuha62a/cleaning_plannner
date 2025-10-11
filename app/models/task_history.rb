# app/models/task_history.rb
class TaskHistory < ApplicationRecord
  belongs_to :task
  belongs_to :user

  enum :status_before, Task.statuses, prefix: true
  enum :status_after,  Task.statuses, prefix: true

  enum :source, {
    manual: 0,
    system: 1,
    line_bot: 2,
    email_reply: 3
  }, prefix: true
end
