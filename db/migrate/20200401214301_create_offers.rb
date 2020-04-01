class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :store, foreign_key: true
      t.integer :stock
      t.float :price
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
