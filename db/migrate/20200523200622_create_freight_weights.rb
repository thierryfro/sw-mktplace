class CreateFreightWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :freight_weights do |t|
      t.integer :min_weight
      t.integer :max_weight
      t.timestamps
    end
  end
end
