class CreateTaskHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :task_histories do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :done_at
      t.integer :status_before
      t.integer :status_after
      t.integer :source
      t.text :note

      t.timestamps
    end
  end
end
