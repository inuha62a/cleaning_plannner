class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :group_role
      t.string :contact_type
      t.string :contact_value
      t.boolean :is_temporary
      t.datetime :registered_at
      t.string :registration_token
      t.datetime :token_expires_at
      t.datetime :invited_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
