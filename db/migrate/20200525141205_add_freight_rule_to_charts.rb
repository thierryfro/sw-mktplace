class AddFreightRuleToCharts < ActiveRecord::Migration[5.2]
  def change
    add_reference :charts, :freight_rule, foreign_key: true
  end
end
