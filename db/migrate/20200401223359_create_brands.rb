class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string "name"
      t.string "logo"
      t.string "search_name"
      t.timestamps
    end
  end
end
