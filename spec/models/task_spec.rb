# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#next_due_date' do
    it 'calculates next due date for weekly task' do
      task = build(:task, frequency: :weekly, last_done_at: Date.today)
      expect(task.calculate_next_due_date).to eq(Date.today + 7)
    end
    it 'returns nil if last_done_at is nil (no history yet)' do
      task = build(:task, frequency: :weekly, last_done_at: nil)
      expect(task.calculate_next_due_date).to be_nil
    end    
  end
end