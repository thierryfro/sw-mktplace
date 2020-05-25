# frozen_string_literal: true

class ChartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :chart, optional: true

  validates :quantity, presence: true

  before_save :calculate_freight,
              unless: proc { |order| order.chart.chart_offers.empty? }

  def products
    offer.products
  end

  def store
    offer.store
  end

  def find_freight_rule(weight)
    store_freight_rules = offer.store.freight_rules
    store_freight_rules
      .joins(:freight_weight)
      .joins(:zip_code_zones)
      .where(
        'freight_weights.min_weight <= ? AND freight_weights.max_weight >= ?',
        weight, weight
      )
      .where(
        'zip_code_zones.start_zip_code <= ? AND zip_code_zones.end_zip_code >= ?',
        '02000000', '02000000'
      )
      .first
  end

  def calculate_freight
    total_weight = chart.chart_offers.reduce(0) do |total, current_offer|
      offer_weight = current_offer.products.sum(&:parsed_weight)
      total + (offer_weight * current_offer.quantity)
    end
    freight_rule = find_freight_rule(total_weight)
    puts total_weight
    puts (freight_rule ? freight_rule.name : "Essa loja não entrega na sua região")
  end
end

