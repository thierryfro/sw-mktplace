class CreateFreightRules < ActiveRecord::Migration[5.2]
  def change
    create_table :freight_rules do |t|
      t.integer :price
      t.string :name
      t.references :store, foreign_key: true
      t.timestamps
    end
  end
end
