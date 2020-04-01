class CreateUserStores < ActiveRecord::Migration[5.2]
  def change
    create_table :user_stores do |t|
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
