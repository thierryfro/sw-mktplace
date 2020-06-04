class CreateCartOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_offers do |t|
      t.references :offer, foreign_key: true
      t.integer :quantity
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
