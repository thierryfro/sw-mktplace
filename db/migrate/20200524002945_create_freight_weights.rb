class CreateFreightWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :freight_weights do |t|
      t.integer :min_weight
      t.integer :max_weight
      t.references :freight_rule, foreign_key: true
      t.timestamps
    end
  end
end