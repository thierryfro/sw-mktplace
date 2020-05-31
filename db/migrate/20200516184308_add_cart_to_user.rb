class AddCartToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :cart, foreign_key: true
  end
end
