class AddPaymentToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :expires_in, :string
    add_column :stores, :user_id, :integer
  end
end
