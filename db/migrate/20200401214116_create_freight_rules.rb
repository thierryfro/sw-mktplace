class CreateFreightRules < ActiveRecord::Migration[5.2]
  def change
    create_table :freight_rules do |t|
      t.float :limit_price
      t.float :discount
      t.references :freight_zone, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
