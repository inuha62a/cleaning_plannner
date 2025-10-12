class User < ApplicationRecord
  # Devise モジュールの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable # ← Confirmableを使うので追加
  # 権限管理
  enum :global_role, { general: 0, admin: 1 }

  # 関連付け
  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id"
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :locations, dependent: :destroy
  has_many :tasks
  has_many :task_histories

  # STEP6で追加予定のソフトデリート対応（今は未記述でOK）
  # acts_as_paranoid if column_names.include?("deleted_at")
end
