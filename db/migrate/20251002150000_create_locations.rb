class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :group, null: true, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
