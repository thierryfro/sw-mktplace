require 'mercadopago.rb'

class CartsController < ApplicationController

  skip_before_action :require_admin
  before_action :authenticate_user!, only: :checkout

  def show
    if current_user
      @cart = Cart.find(current_user.cart_id)
      @cart_offers = @cart.cart_offers
    else
      @cart_offers = CartOffer.where(cart_id: session[:cart_id])
    end
    @freight = @cart.freight_rule
  end

  # def session_offers(cart_offers)
  #   offers = []
  #   cart_offers.each do |offer|
  #     session_offers << offer
  #   end
  #   offers
  # end

  def checkout

    # Sem user chega o @cart == session[:cart_id]
    @session_cart = Cart.find(session[:cart_id])

    # Depois que authenticate, user tera outro cart, passar os produtos do cart_session pro cart_user
    unless @session_cart.cart_offers.empty?
      @cart.cart_offers.destroy_all
      @session_cart.cart_offers.each do |cart_offer|
        @cart.cart_offers << cart_offer
      end
    end

    # Começo da Order
    # Configura credenciais
    $mp = MercadoPago.new(ENV['PROD_ACCESS_TOKEN'])

    # Cria um objeto de preferência
    items = []
    @cart.cart_offers.each do |cart_offer|
      items << { title: cart_offer.offer.id, unit_price: cart_offer.offer.price, quantity: cart_offer.quantity }
    end
    preference_data = {
      "items": items
    }
    preference = $mp.create_preference(preference_data)

    # Este valor substituirá a string "<%= @preference_id %>" no seu HTML
    @preference_id = preference["response"]["id"]
  end
end
