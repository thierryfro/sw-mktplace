class CreateOrderOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :order_offers do |t|
      t.references :offer, foreign_key: true
      t.references :order, foreign_key: true
      t.string :recorded_value

      t.timestamps
    end
  end
end
