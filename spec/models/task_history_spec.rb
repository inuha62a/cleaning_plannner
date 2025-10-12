require 'rails_helper'

RSpec.describe TaskHistory, type: :model do
  describe 'バリデーション' do
    it '有効な属性があれば履歴は保存できること'  do
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

  describe 'ステータスの遷移' do
    it '完了から未完了に戻す履歴も有効であること' do
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
