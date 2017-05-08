class CreateAbouts < ActiveRecord::Migration[5.0]
  def change
    create_table :abouts do |t|
      t.integer :type_about
      t.text :description
      t.timestamps
    end
  end
end
