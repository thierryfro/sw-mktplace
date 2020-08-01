class AddCollumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :freight_rule, foreign_key: true
    add_column :orders, :payment_type, :string
    add_column :orders, :installments, :integer
    add_column :orders, :taxes_amount, :decimal
    add_column :orders, :transaction_amount, :decimal
    add_column :orders, :shipping_amount, :integer
    add_column :orders, :marcadopago_fee, :integer
    add_column :orders, :collector_id, :integer
  end
end
