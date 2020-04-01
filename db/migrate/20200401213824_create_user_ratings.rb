class CreateUserRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_ratings do |t|
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true
      t.integer :rating
      t.text :description

      t.timestamps
    end
  end
end
