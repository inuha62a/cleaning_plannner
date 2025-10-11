require 'rails_helper'

RSpec.describe TaskHistory, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = FactoryBot.create(:user)
      task = FactoryBot.create(:task, user: user)
      history = TaskHistory.new(
        task: task,
        user: user,
        done_at: Time.current,
        status_before: :pending,
        status_after: :done,
        source: :manual
      )
      expect(history).to be_valid
    end
  end

  describe 'status transitions' do
    it 'is valid when reverting from done to pending' do
      user = FactoryBot.create(:user)
      task = FactoryBot.create(:task, user: user, status: :done)

      history = TaskHistory.new(
        task: task,
        user: user,
        done_at: Time.current,
        status_before: :done,
        status_after: :pending,
        source: :manual,
        note: 'やり残しがあったので戻しました'
      )

      expect(history).to be_valid
    end
  end
end
