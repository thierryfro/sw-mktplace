class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :cnpj, null: false
      t.string :comercial_name, null: false

      t.timestamps
    end
  end
end
