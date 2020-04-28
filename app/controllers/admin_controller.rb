class AdminController < ApplicationController

  # before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def dashboard
  end

  def offers
    @offers = Offer.order(:store_id).page params[:page]
  end

  def new_offer
    @offer = Offer.new
    @offer.offer_products.build
    @products = Product.all
    @stores = Store.all
  end

  def new_store
    @store = Store.new
    @owners = User.all.pluck(:name, :id)
  end

  private

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active, offer_products_attributes: [:product_id, :_destroy])
  end

  def store_params
    params.require(:store).permit(:name, :email, :cnpj, :comercial_name, :owner_id)
  end

end