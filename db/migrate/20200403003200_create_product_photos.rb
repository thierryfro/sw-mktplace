# frozen_string_literal: true

class CreateProductPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :product_photos do |t|
      t.string 'url'
      t.string 'name'
      t.string 'size'
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
