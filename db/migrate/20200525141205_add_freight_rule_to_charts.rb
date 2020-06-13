class AddFreightRuleToCarts < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :freight_rule, foreign_key: true
  end
end
