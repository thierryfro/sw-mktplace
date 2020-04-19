class OffersController < ApplicationController

  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    @offers = Offer.all
  end

  def show
  end

  def new
    @offer = Offer.new
    @offer.offer_products.build
    @products = Product.all
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      flash[:notice] = "Loja criada com sucesso!"
      redirect_to @offer
    else
      flash[:notice] = "Algo errado não está certo!"
      render :new
    end
  end

  def edit
    @products = Product.all
  end

  def update
    @offer.update(offer_params)
    redirect_to offer_path(@offer)
  end

  def destroy
    # @offer.destroy
    # redirect_to offers_path
  end

  def product_list
    @products = Product.order(:name).page params[:page]
  end

  private

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active, offer_products_attributes: [:product_id, :_destroy])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
