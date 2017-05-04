class CreateRuleId3s < ActiveRecord::Migration[5.0]
  def change
    create_table :rule_id3s do |t|
      t.integer :clump_thickness
      t.integer :uniformity_of_cell_size
      t.integer :uniformity_of_cell_shape
      t.integer :marginal_adhesion
      t.integer :single_epithelial_cell_size
      t.integer :bare_nuclei
      t.integer :bland_chromatin
      t.integer :normal_nucleoli
      t.integer :mitoses
      t.references :classification, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
