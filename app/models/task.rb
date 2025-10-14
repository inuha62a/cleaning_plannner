class Task < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  belongs_to :group, optional: true
  has_many :notifications, dependent: :destroy
  has_many :task_histories

  # enumはRails8以降位置引数スタイルが推奨になり旧記法が廃止になるので、位置因数で記載。(Rails7ならまだ旧記法でも動く)
  enum :frequency, { daily: 0, weekly: 1, every_5_days: 2, monthly: 3, custom: 4 }
  enum :status, { pending: 0, done: 1, skipped: 2, overdue: 3 }

  def calculate_next_due_date
    return nil unless last_done_at  # ← 初回は前回実施がnilなので次の予定日もnilになる

    case frequency.to_sym
    when :daily
      last_done_at + 1.day
    when :weekly
      last_done_at + 7.days
    when :every_5_days
      last_done_at + 5.days
    when :monthly
      last_done_at + 1.month
    when :custom
      return nil unless custom_interval_days
      last_done_at + custom_interval_days.days
    else
      nil
    end
  end

  # タスクを完了済みにし、last_done_atを現在時刻に更新するメソッド
  def mark_as_done!
    update!(status: :done, last_done_at: Time.current)
  end
end
