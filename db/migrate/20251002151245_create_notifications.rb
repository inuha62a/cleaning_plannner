class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :enabled
      t.integer :method
      t.datetime :scheduled_at
      t.datetime :sent_at

      t.timestamps
    end
  end
end
