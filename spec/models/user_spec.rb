require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it '正しい情報があればユーザーは有効になること' do
    expect(user).to be_valid
  end
end
