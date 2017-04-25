class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.text :name
      t.references :user, foreign_key: true
      t.text :description
      t.string :image
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
