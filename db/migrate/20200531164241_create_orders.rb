class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :store, foreign_key: true
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
      t.string :preference_id
      t.string :payment_id
      t.string :payment_status
      t.string :payment_status_detail
      t.string :merchant_order_id
      t.string :processing_mode
      t.string :merchant_account_id

      t.timestamps
    end
  end
end
