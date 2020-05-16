class AddParsedWeightToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :parsed_weight, :integer
  end
end
