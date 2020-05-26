# frozen_string_literal: true

class ChartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :chart, optional: true

  validates :quantity, presence: true

  after_save :calculate_freight

  def products
    offer.products
  end

  def store
    offer.store
  end

  def find_freight_rule
    weight = chart.total_weight
    store_freight_rules = store.freight_rules
    store_freight_rules
      .joins(:freight_weight)
      .joins(:zip_code_zones)
      .where(
        'freight_weights.min_weight <= ? AND freight_weights.max_weight >= ?',
        weight, weight
      )
      .where(
        'zip_code_zones.start_zip_code <= ? AND zip_code_zones.end_zip_code >= ?',
        '04900000', '04900000'
      )
      .first
  end

  def calculate_freight
    return chart.update!(freight_rule_id: nil) if chart.chart_offers.empty?
    # find freight rule to match with weight X zip_code
    freight_rule = find_freight_rule
    if freight_rule
      chart.update!(freight_rule_id: freight_rule.id)
    else
      chart.update!(freight_rule_id: nil)
    end
  end
end
