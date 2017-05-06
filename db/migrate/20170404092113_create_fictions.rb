class CreateFictions < ActiveRecord::Migration[5.0]
  def change
    create_table :fictions do |t|
      t.string :name
      t.string :code
      t.string :code_data
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
