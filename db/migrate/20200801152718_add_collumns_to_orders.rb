class AddCollumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :freight_rule, foreign_key: true
    add_column :orders, :payment_type, :string
    add_column :orders, :installments, :integer
    add_column :orders, :taxes_amount, :float
    add_column :orders, :transaction_amount, :float
    add_column :orders, :shipping_amount, :float
    add_column :orders, :application_fee, :float
    add_column :orders, :mercadopago_fee, :float
    add_column :orders, :collector_id, :integer
    add_column :orders, :mp_response, :string
    add_column :orders, :date_approved, :datetime

    remove_column :orders, :preference_id
    remove_column :orders, :processing_mode
    remove_column :orders, :merchant_account_id
  end
end

