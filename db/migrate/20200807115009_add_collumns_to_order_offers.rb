class AddCollumnsToOrderOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :order_offers, :description, :string
    add_column :order_offers, :unit_price, :float
    add_column :order_offers, :total_price, :float
    add_column :order_offers, :unit_weight, :string
    add_column :order_offers, :quantity, :integer
    add_column :order_offers, :image_url, :string
    remove_column :order_offers, :recorded_value, :string
  end
end

