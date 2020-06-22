# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :set_offer, only: %i[show edit update destroy]
  before_action :sidebar_params, only: %i[index]
  before_action :set_offers, only: %i[index]

  skip_before_action :require_admin

  def index
    @offers = @offers.sample(25)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show; end

  def new
    @offer = Offer.new
    @offer.offer_products.build
    @products = Product.all
    @stores = if current_user&.admin?
                Store.all
              else
                Store.where(owner_id: current_user)
              end
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      flash[:notice] = 'Oferta criada com sucesso!'
      redirect_to @offer
    else
      flash[:notice] = 'Algo errado não está certo!'
      render :new
    end
  end

  def edit
    unless @offer.store.owner != current_user || current_user.admin?
      flash[:notice] = 'Você não tem permissão para fazer isso!'
      redirect_to root_path
    end
    @products = Product.all
    @stores = if current_user&.admin?
                Store.all
              else
                Store.where(owner_id: current_user)
              end
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

  def set_offers
    products = Product.all
    filters = params['search']
    if filters.present?
      filters.keys.each { |filter| filters[filter].reject!(&:blank?) }
      products = products.where(brand_id: filters["brands"]) if filters["brands"].present?
      products = products.where(category_id: filters["categories"]) if filters["categories"].present?
      products = products.where(subcategory_id: filters["subcategories"]) if filters["subcategories"].present?
      products = products.where(weight: filters["weights"]) if filters["weights"].present?
    end
    products = products.search_products(params['query']) if params['query'].present?
    @offers = Offer.includes(products: :product_photos).where(products: { id: products.pluck(:id) })
  end

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active, offer_products_attributes: %i[product_id _destroy])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def sidebar_params
    products_ids = OfferProduct.all&.pluck(:product_id)&.uniq # takes the product identifier that contains offers
    products = Product.where(id: products_ids)&.uniq #
    @brands = Brand.where(id: products&.pluck(:brand_id))&.pluck([:name, :id])&.reject(&:blank?)&.uniq
    @categories = Category.where(id: products&.pluck(:category_id))&.pluck([:name, :id])&.reject(&:blank?)&.uniq
    @subcategories = Subcategory.where(id: products&.pluck(:subcategory_id))&.pluck([:name, :id])&.reject(&:blank?)&.uniq
    @weights = products&.pluck(:weight)&.reject(&:blank?)&.uniq
  end
end
