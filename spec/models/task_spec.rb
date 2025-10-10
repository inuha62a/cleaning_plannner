# spec/models/task_spec.rb
require 'rails_helper'

describe '#calculate_next_due_date' do
  # テストの安全性のために固定日付を使用
  let(:base_date) { Date.new(2025, 10, 10) }

  it 'calculates next due date for daily task' do
    task = build(:task, frequency: :daily, last_done_at: base_date)
    expect(task.calculate_next_due_date).to eq(base_date + 1)
  end

  it 'calculates next due date for weekly task' do
    task = build(:task, frequency: :weekly, last_done_at: base_date)
    expect(task.calculate_next_due_date).to eq(base_date + 7)
  end

  it 'calculates next due date for every_5_days task' do
    task = build(:task, frequency: :every_5_days, last_done_at: base_date)
    expect(task.calculate_next_due_date).to eq(base_date + 5)
  end

  it 'calculates next due date for monthly task' do
    task = build(:task, frequency: :monthly, last_done_at: base_date)
    expect(task.calculate_next_due_date).to eq(base_date + 1.month)
  end

  it 'calculates next due date for custom task with interval' do
    task = build(:task, frequency: :custom, last_done_at: base_date, custom_interval_days: 3)
    expect(task.calculate_next_due_date).to eq(base_date + 3)
  end

  it 'returns nil for custom task if custom_interval_days is nil' do
    task = build(:task, frequency: :custom, last_done_at: base_date, custom_interval_days: nil)
    expect(task.calculate_next_due_date).to be_nil
  end

  it 'returns nil if last_done_at is nil (no history yet)' do
    task = build(:task, frequency: :weekly, last_done_at: nil)
    expect(task.calculate_next_due_date).to be_nil
  end
end
