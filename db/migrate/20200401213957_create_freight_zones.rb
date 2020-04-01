class CreateFreightZones < ActiveRecord::Migration[5.2]
  def change
    create_table :freight_zones do |t|
      t.string :zone
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
