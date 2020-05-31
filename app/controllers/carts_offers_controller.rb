class CartsOffersController < ApplicationController

  skip_before_action :require_admin


  def create
    @cartoffer_tooked = CartOffer.find_by(cart_id: @cart, offer_id: params[:offer_id]);
    if @cart.cart_offers.empty?
      @cart_offer = CartOffer.create(offer_id: params[:offer_id], quantity: 1, cart_id: @cart.id)
    elsif @cart.cart_offers.include?(@cartoffer_tooked)
      @cart_offer = CartOffer.find_by(id: @cartoffer_tooked)
      @cart_offer.quantity += 1
    else
      @cart_offer = CartOffer.create(offer_id: params[:offer_id], quantity: 1, cart_id: @cart.id)
    end
    # @cart.user = current_user if current_user # Se user ja estiver logado, ja atribui o cart para current_user, senao sera feito no checkout
    @cart.save
    if @cart_offer.save
      # Analisar aqui -> Pode ter mais de uma cartoffer?
      session[:cart_offer_id] = @cart_offer.id
      flash[:notice] = "Oferta adicionada!"
      redirect_to '/cart'
    else
      flash[:notice] = "Erro, nao foi possivel adicionar a oferta"
      redirect_to offers_path
    end
  end

  def add
    @cart_offer = CartOffer.find(params[:cart_offer_id])
    @cart_offer.quantity += 1
    @cart_offer.save
    redirect_to '/cart'
  end

  def remove
    @cart_offer = CartOffer.find(params[:cart_offer_id])
    if @cart_offer.quantity > 1
      @cart_offer.quantity -= 1
    else
      @cart_offer.destroy
    end
    @cart_offer.save
    redirect_to '/cart'
  end

  private

  def cart_offer_params
    params.require(:cart_offer).permit(:offer_id)
  end
end
