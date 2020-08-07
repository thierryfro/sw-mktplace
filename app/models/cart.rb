# frozen_string_literal: true

class Cart < ApplicationRecord
  has_one :user
  has_many :offers, through: :cart_offers
  has_many :cart_offers, dependent: :destroy
  belongs_to :freight_rule, optional: true
  belongs_to :address, optional: true

  def total_weight
    return 0 if cart_offers.empty?

    # sum all cart_offers products parsed_weights from cart
    cart_offers.reduce(0) do |total, current_offer|
      offer_weight = current_offer.products.sum(&:parsed_weight)
      total + (offer_weight * current_offer.quantity)
    end
  end

  def update_freight
    if cart_offers.empty?
      update!(freight_rule_id: nil)
      return 'Seu carrinho está vazio'
    end

    store = cart_offers.first.store
    # given a zip code find store rules
    zone_rules = store.find_zone_rules(address.zipcode)
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

  def fill_cart(session)
    session_cart = Cart.find(session[:cart_id])
    update!(
      cart_offers: session_cart.cart_offers,
      address_id: session_cart.address_id,
      freight_rule_id: session_cart.freight_rule_id
    )
  end

  def calc_subtotal
    cart_offers.reduce(0) do |subtotal, cart_offer|
      subtotal + (cart_offer.offer.price * cart_offer.quantity)
    end
  end

  def count_items
    cart_offers.sum(&:quantity)
  end

  def cart_store
    cart_offers.first.store if cart_offers.present?
  end

  def store
    cart_offers.present? ? cart_offers.first.store : nil
  end

  def payment_items
    cart_offers.map do |cart_offer|
      product = cart_offer.product
      {
        "id": product.id,
        "title": product.name,
        "quantity": cart_offer.quantity,
        "unit_price": cart_offer.offer.price,
        "category_id": product.category.name
      }.stringify_keys
    end
  end
end
