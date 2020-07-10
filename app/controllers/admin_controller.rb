# frozen_string_literal: true

class AdminController < ApplicationController
  # before_action :set_offer, only: [:show, :edit, :update, :destroy]
  skip_before_action :set_address
  before_action :set_store, only: %i[offers profile]

  layout 'admin_layout'

  def dashboard; end

  def offers
    @store = Store.find_by(owner_id: current_user.id)

    @offers = Offer.joins(:products).where(store: @store).order('products.product_code', 'products.weight DESC')
    query = params[:admin_query]
    search_offers(query) if query.present?
    @offers = @offers.page params[:page]
  end

  def profile; end

  def edit_profile
    if current_user.update!(user_params)
      flash[:notice] = 'Perfil atualizado com sucesso!'
    else
      flash[:notice] = 'Algo errado não está certo!'
    end
    redirect_to admin_profile_path
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

  def user_params
    params.require(:user).permit(:name, :last_name, :birthdate, :photo)
  end

  def set_store
    @store = Store.find_by(owner_id: current_user.id)
  end

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active, offer_products_attributes: %i[product_id _destroy])
  end

  def store_params
    params.require(:store).permit(:name, :email, :cnpj, :comercial_name, :owner_id)
  end

  def search_offers(query)
    products = Product.search_products(query)
    @offers = @offers.where(products: { id: products.pluck(:id) })
  end
end
