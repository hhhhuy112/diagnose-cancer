class CreateValueFictions < ActiveRecord::Migration[5.0]
  def change
    create_table :value_fictions do |t|
      t.string :name
      t.integer :value
      t.integer :description
      t.references :fiction, foreign_key: true

      t.timestamps
    end
  end
end
