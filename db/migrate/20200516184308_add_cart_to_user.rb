class AddCartToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :chart, foreign_key: true
  end
end
