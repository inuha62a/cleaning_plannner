class User < ApplicationRecord
  # Devise モジュールの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable # ← Confirmableを使うので追加
  # 権限管理
  enum global_role: { member: 0, admin: 1 }

  # STEP6で追加予定のソフトデリート対応（今は未記述でOK）
  # acts_as_paranoid if column_names.include?("deleted_at")

end
