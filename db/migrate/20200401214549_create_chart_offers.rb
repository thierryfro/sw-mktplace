class CreateChartOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :chart_offers do |t|
      t.references :offer, foreign_key: true
      t.integer :quantity
      t.references :chart, foreign_key: true

      t.timestamps
    end
  end
end
