class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.integer :owner_id
      t.integer :patient_id
      t.references :classification, foreign_key: true
      t.float :result
      t.integer :type_diagnose
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :diagnoses, :owner_id
    add_index :diagnoses, :patient_id
  end
end
