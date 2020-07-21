# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :set_offer, only: %i[show edit update destroy]
  before_action :sidebar_params, only: %i[index store]
  before_action :set_offers, only: %i[index store]
  before_action :set_store, only: %i[store]
  skip_before_action :require_admin

  def index
    @offers = @offers.sample(25)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @product = @offer.products.first
  end

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
    puts params
    unless @offer.store.owner != current_user || current_user.admin?
      flash[:notice] = 'Você não tem permissão para fazer isso!'
      redirect_to root_path
    end
    if @offer.update!(offer_params)
      flash[:notice] = 'Sua oferta foi atualizada com sucesso!'
    else
      flash[:notice] = 'Algo deu errado'
      redirect_to all_offers
    end
  end

  def destroy
    # @offer.destroy
    # redirect_to offers_path
  end

  def store
    @offers = @offers.sample(25)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def handle_prices(prices)
    prices = prices.split(',')
    prices.map! { |price| price.gsub(/\D/, '') }
    set_prices(prices[0], prices[1])
    @offers.where('price >= ? AND price <= ?', prices[0], prices[1])
  end

  def set_offers
    if @cart.address.nil?
      flash[:notice] = "Insira um endereço válido"
      redirect_to root_path
    else
      products = Product.all
      filters = params['search']
      if filters.present?
        filters.keys.each { |filter| filters[filter].reject!(&:blank?) if filters[filter].class == Array }
        products = products.where(brand_id: filters['brands']) if filters['brands'].present?
        products = products.where(category_id: filters['categories']) if filters['categories'].present?
        products = products.where(subcategory_id: filters['subcategories']) if filters['subcategories'].present?
        products = products.where(weight: filters['weights']) if filters['weights'].present?
        prices = filters['prices'] if filters['prices'].present?
      end
      products = products.search_products(params['query']) if params['query'].present?
      @offers = Offer.includes(products: [:product_photos, :brand])
                    .where(
                      products: { id: products.pluck(:id) },
                      store_id: params[:store_id].present? ? params[:store_id] : Store.delivers_in(@cart.address.zipcode)
                    ).includes(:offer_products, :store)
      @offers = handle_prices(prices) if prices
    end
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
    @brands = Brand.where(id: products&.pluck(:brand_id))&.order(:name).pluck(%i[name id])&.reject(&:blank?)&.uniq
    @categories = Category.where(id: products&.pluck(:category_id))&.order(:name).pluck(%i[name id])&.reject(&:blank?)&.uniq
    @subcategories = Subcategory.where(id: products&.pluck(:subcategory_id))&.order(:name).pluck(%i[name id])&.reject(&:blank?)&.uniq
    @weights = products&.pluck(:weight)&.reject(&:blank?)&.uniq
    set_prices
  end

  def set_prices(start_price = nil, end_price = nil)
    @prices = [{
      start: Offer.all.order(:price).first.price,
      end: Offer.all.order(price: :desc).first.price,
      current_start: start_price.to_i,
      current_end: end_price.to_i
    }].to_json
  end

  def set_store
    @store = Store.find(params[:store_id])
  end
end
