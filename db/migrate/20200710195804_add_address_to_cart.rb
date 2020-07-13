class AddAddressToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :address, foreign_key: true
  end
end
