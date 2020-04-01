class AddOwnerToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :owner_id, :integer
    add_index :stores, :owner_id
  end
end
