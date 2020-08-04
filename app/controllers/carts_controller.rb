
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
end
