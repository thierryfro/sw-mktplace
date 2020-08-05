class AddMpResponseToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :mp_response, :string
  end
end
