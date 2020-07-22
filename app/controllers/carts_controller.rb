
require 'mercadopago.rb'

class CartsController < ApplicationController
  skip_before_action :require_admin
  before_action :authenticate_user!, only: :payment
  # before_action :authenticate_user!, only: :checkout

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
  
  def payment
    @store = @cart.store
    @amount = @cart.calc_subtotal
    @store = @cart.store
    @quantity = @cart.count_items
  end

  def checkout
    $mp = MercadoPago.new(@cart.store.access_token)
    response = $mp.post('/v1/payments', payment_data)
    raise
    manage_payment(response)

    # Este valor substituirá a string "<%= @preference_id %>" no seu HTML
  end

  def sucess; end

  private

  def manage_payment(response)
    raise

  end

  def payment_data
    payment_data = payment_params
    {
      "transaction_amount": payment_data['transaction_amount'].to_i,
      "token": payment_data['token'],
      "description": payment_data['description'],
      "installments": payment_data['installments'].to_i,
      "payment_method_id": payment_data['payment_method_id'],
      "payer": {
        "email": payment_data['email']
      }
    }
  end

  def payment_params
    params.permit(
      :transaction_amount, :token, :description,
      :installments, :payment_method_id, :email
    )
  end
end
