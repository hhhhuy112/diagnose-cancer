class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
      t.references :classification, foreign_key: true
      t.references :fiction, foreign_key: true
      t.integer :value, default: 0
      t.float :probability

      t.timestamps
    end
  end
end
