class OffersController < ApplicationController
  before_action :set_offer, only: %i[show edit update destroy]
  skip_before_action :require_admin

  def index
    if params['search']

      @filter = [params['search']['categories']].concat([params['search']['brands']])
                                                .concat([params['search']['subcategories']])
                                                .concat([params['search']['weight']])
                                                .concat([params['search']['query']]).flatten.reject(&:blank?)

      products = @filter.empty? ? Product.all : Product.search_products(@filter.to_s)
      @offers = Offer.includes(products: :product_photos).where(products: { id: products.pluck(:id) })
    else
      @offers = Offer.all
    end
    redirect_to offers_path if @offers.empty?
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
    @offer.update(offer_params)
    redirect_to offer_path(@offer)
  end

  def destroy
    # @offer.destroy
    # redirect_to offers_path
  end

  private

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active, offer_products_attributes: %i[product_id _destroy])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
