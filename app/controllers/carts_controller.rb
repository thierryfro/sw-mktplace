# frozen_string_literal: true

class CartsController < ApplicationController
  skip_before_action :require_admin
  before_action :authenticate_user!, only: :checkout

  def show
    if current_user
      @cart = Cart.find(current_user.cart_id)
      @cart_offers = @cart.cart_offers.order(created_at: :desc)
    else
      @cart = Cart.find(session[:cart_id])
      @cart_offers = CartOffer.where(cart_id: session[:cart_id]).order(created_at: :desc)
    end
    @freight = @cart.freight_rule
    if @cart_offers
      @subtotal = @cart.calc_subtotal
      @sugested_offers = Offer.where(store: @cart.cart_store).sample(4)
    end
  end

  # def session_offers(cart_offers)
  #   offers = []
  #   cart_offers.each do |offer|
  #     session_offers << offer
  #   end
  #   offers
  # end

  def checkout

    amount = @cart.calc_subtotal 
    store = @cart.store
    quantity = @cart.count_items

    raise
    # items = []
    # @cart.cart_offers.each do |cart_offer|
    #   items << {
    #     title: cart_offer.offer.id,
    #     unit_price: cart_offer.offer.price,
    #     quantity: cart_offer.quantity,
    #     currency_id: "BRL"
    #   }
    # end
    # require 'mercadopago'

    # MercadoPago::SDK.configure(ACCESS_TOKEN: ENV["PROD_ACCESS_TOKEN"])

    # payment = MercadoPago::Payment.new()
    # payment.transaction_amount = amount
    # payment.token = store.access_token
    # payment.description = 'Title of what you are paying for'
    # payment.installments = 1
    # payment.payment_method_id = "visa"
    # payment.payer = {
    #   email: "test_user_69207677@testuser.com"
    # }

    # payment.save()

    url = "https://api.mercadopago.com/v1/payments?access_token=#{ENV["PROD_ACCESS_TOKEN"]}"

    headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    }
    body = {
      "transaction_amount": amount,
      "token": store.access_token,
      "description": "Title of what you are paying for",
      "installments": 1,
      "payer": {
        "id": "584422973"
      },
      "payment_method_id": "visa",
      "application_fee": 2.56
    }

    response = RestClient.post(url, body, headers)
    response = JSON.parse(response)

    # Este valor substituirá a string "<%= @preference_id %>" no seu HTML
  end

  def sucess
  end

end

# \    curl -X POST \
# -H 'Accept: application/json' \
# -H 'Content-Type: application/json' \
# 'https://api.mercadopago.com/v1/advanced_payments?access_token=TEST-4621434340573915-071322-132cb43e76a224ae6b7b99a719e388f9-558584930' \
# -d '{
#   "payer": {
#     "email": "test@user.com"
#   },
#   "payments": [
#     {
#       "payment_method_id": "visa",
#       "payment_type_id": "credit_card",
#       "token": "UHinzdTVOLjy9YGWVPpH7HMyh5krao7b",
#       "transaction_amount": 1000,
#       "installments": 1,
#       "processing_mode": "aggregator"
#     }
#   ],
#   "disbursements": [
#     {
#       "amount": 1000,
#       "external_reference": "ref-collector-1",
#       "collector_id": 558585522,
#       "application_fee": 100,
#       "money_release_days": 30
#     }
#   ],
#   "external_reference": "ref-transaction"
# }'