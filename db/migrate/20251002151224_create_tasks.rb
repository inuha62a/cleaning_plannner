class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: true, foreign_key: true
      t.references :group, null: true, foreign_key: true
      t.string :title
      t.integer :frequency
      t.datetime :last_done_at
      t.datetime :next_due_date
      t.integer :custom_interval_days
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
