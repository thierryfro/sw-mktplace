class CreateZipCodeZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zip_code_zones do |t|
      t.string :start_zip_code
      t.string :end_zip_code
      t.timestamps
    end
  end
end
