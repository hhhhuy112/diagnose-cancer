class CreateDataUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :data_users do |t|
      t.integer :value
      t.references :fiction, foreign_key: true
      t.references :diagnose, foreign_key: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
