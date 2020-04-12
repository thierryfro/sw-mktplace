# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string 'name'
      t.string 'weight'
      t.string 'flavor'
      t.string 'ean'
      t.string 'description'
      t.integer 'api_code'
      t.references :brand, foreign_key: true
      t.references :category, foreign_key: true
      t.references :subcategory, foreign_key: true
      t.timestamps
    end
  end
end
