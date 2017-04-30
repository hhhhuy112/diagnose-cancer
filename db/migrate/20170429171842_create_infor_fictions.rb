class CreateInforFictions < ActiveRecord::Migration[5.0]
  def change
    create_table :infor_fictions do |t|
      t.references :fiction, foreign_key: true
      t.float :gain_infor
      t.float :potential_infor
      t.float :gain_ratio
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
