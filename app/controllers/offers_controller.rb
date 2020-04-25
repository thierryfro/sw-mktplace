class OffersController < ApplicationController

  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index

    # if params["search"]
    #   @filter = params["search"]["flavors"].concat(params["search"]["brands"]).flatten.reject(&:blank?)
    #   @cocktails = @filter.empty? ? Cocktail.all : Cocktail.all.tagged_with(@filter, any: true)
    # else
    #   @cocktails = Cocktail.all
    # end

    if params["search"]
      @filter = params["search"]["categories"].concat(params["search"]["brands"]).
                                              concat(params["search"]["subcategories"]).
                                              concat(params["search"]["weight"]).flatten.reject(&:blank?)
      # @filter << params[:search][:query] if params[:search][:query]

      products = @filter.empty? ? [] : Product.all.tagged_with(@filter, any: true)
      # products = @filter.empty? ? [] : Product.all.search_products(@filter)
      # products = Product.search_products(params["search"])
      @offers = Offer.includes(:products).where(products: {id: products.pluck(:id)})
    else
      @offers = Offer.all
    end
    respond_to do |format|
      format.html
      format.js
    end
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

  private

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active, offer_products_attributes: [:product_id])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
