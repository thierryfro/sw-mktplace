class AddFieldsToStore < ActiveRecord::Migration[5.2]
  def change
    add_reference :stores, :address, foreign_key: true
    add_column :stores, :access_token, :string
    add_column :stores, :public_key, :string
    add_column :stores, :refresh_token, :string
  end
end
