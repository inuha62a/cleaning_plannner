# spec/models/task_spec.rb
require 'rails_helper'

describe '次回期限の計算' do
  # テストの安全性のために固定日付を使用
  let(:基準日) { Date.new(2025, 10, 10) }

  it '日次タスクの次回期限が翌日になること' do
    task = build(:task, frequency: :daily, last_done_at: 基準日)
    expect(task.calculate_next_due_date).to eq(基準日 + 1)
  end

  it '週次タスクの次回期限が7日後になること' do
    task = build(:task, frequency: :weekly, last_done_at: 基準日)
    expect(task.calculate_next_due_date).to eq(基準日 + 7)
  end

  it '5日ごとのタスクの次回期限が5日後になること' do
    task = build(:task, frequency: :every_5_days, last_done_at: 基準日)
    expect(task.calculate_next_due_date).to eq(基準日 + 5)
  end

  it '月次タスクの次回期限が1ヶ月後になること' do
    task = build(:task, frequency: :monthly, last_done_at: 基準日)
    expect(task.calculate_next_due_date).to eq(基準日 + 1.month)
  end

  it 'カスタム間隔が指定されている場合、次回期限がその日数後になること' do
    task = build(:task, frequency: :custom, last_done_at: 基準日, custom_interval_days: 3)
    expect(task.calculate_next_due_date).to eq(基準日 + 3)
  end

  it 'カスタム間隔がnilの場合、次回期限がnilになること' do
    task = build(:task, frequency: :custom, last_done_at: 基準日, custom_interval_days: nil)
    expect(task.calculate_next_due_date).to be_nil
  end

  it 'last_done_atがnilの場合、次回期限がnilになること' do
    task = build(:task, frequency: :weekly, last_done_at: nil)
    expect(task.calculate_next_due_date).to be_nil
  end
end

describe 'タスクの完了処理' do
  it 'ステータスがdoneになり、last_done_atが現在時刻に更新されること' do
    task = create(:task, status: :pending, last_done_at: nil)

    freeze_time do
      now = Time.current
      task.mark_as_done!
      expect(task.status).to eq('done')
      expect(task.last_done_at).to eq(now)
    end
  end
end
