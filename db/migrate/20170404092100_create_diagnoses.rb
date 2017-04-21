class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.references :user, foreign_key: true
      t.references :classification, foreign_key: true
      t.float :result
      t.integer :type_diagnose
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
