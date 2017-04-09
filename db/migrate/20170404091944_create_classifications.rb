class CreateClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :classifications do |t|
      t.string :name
      t.float :probability
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
