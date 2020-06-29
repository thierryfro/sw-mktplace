# frozen_string_literal: true

class Chart < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :freight_rule, optional: true
  has_many :chart_offers, dependent: :destroy
  has_many :offers, through: :chart_offers

  def total_weight
    return 0 if chart_offers.empty?

    # sum all chart_offers products parsed_weights from chart
    chart_offers.reduce(0) do |total, current_offer|
      offer_weight = current_offer.products.sum(&:parsed_weight)
      total + (offer_weight * current_offer.quantity)
    end
  end

  def update_freight
    if chart_offers.empty?
      update!(freight_rule_id: nil)
      return 'Seu carrinho está vazio'
    end

    store = chart_offers.first.store
    # given a zip code find store rules
    zone_rules = store.find_zone_rules('04900000')
    if zone_rules.blank?
      update!(freight_rule_id: nil)
      return 'Essa loja não entrega na sua região'
    end
    # given a weight code find store rules
    weight_rules = store.find_weight_rules(total_weight)
    if weight_rules.blank?
      update!(freight_rule_id: nil)
      return 'Seu carrinho excedeu o limite de peso'
    end
    # intersection between two selections
    freight_rule = (zone_rules & weight_rules).first
    update!(freight_rule_id: freight_rule.id)
  end
end
