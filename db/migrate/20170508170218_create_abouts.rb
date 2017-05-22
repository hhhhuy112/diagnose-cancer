class CreateAbouts < ActiveRecord::Migration[5.0]
  def change
    create_table :abouts do |t|
      t.integer :type_about
      t.string :source
      t.string :link
      t.text :description
      t.text :description_vi
      t.timestamps
    end
  end
end
