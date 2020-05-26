class Chart < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :freight_rule, optional: true
  has_many :chart_offers

  def total_weight
    return 0 if chart_offers.empty?

    chart_offers.reduce(0) do |total, current_offer|
      offer_weight = current_offer.products.sum(&:parsed_weight)
      total + (offer_weight * current_offer.quantity)
    end
  end
end
