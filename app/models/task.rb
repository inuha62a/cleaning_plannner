class Task < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  belongs_to :group, optional: true
  has_many :notifications, dependent: :destroy

  enum frequency: {daily: 0, weekly: 1, every_5_days: 2, monthly: 3, custom: 4 }
  enum status: { pending: 0, done: 1 }
end
