class CreateZipCodeZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zip_code_zones do |t|
      t.string :name
      t.string :district
      t.string :start_zip_code
      t.string :end_zip_code
      t.references :freight_rule, foreign_key: true
      t.timestamps
    end
  end
end
