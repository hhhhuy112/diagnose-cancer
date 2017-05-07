class CreateTestAlgorithms < ActiveRecord::Migration[5.0]
  def change
    create_table :test_algorithms do |t|
      t.integer :type_diagnose
      t.integer :type_data
      t.float :true_probability
      t.float :fault_probability
      t.float :not_condition_probability
      t.timestamps
    end
  end
end
