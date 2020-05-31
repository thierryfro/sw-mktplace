class AddProductCodeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :product_code, :integer
  end
end
