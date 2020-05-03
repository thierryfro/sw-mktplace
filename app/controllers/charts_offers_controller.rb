class ChartsOffersController < ApplicationController

  skip_before_action :require_admin


  def create
    @chartoffers_tooked = ChartOffer.where(offer_id: params[:offer_id], chart_id: @cart.id).pluck(:id) # Offer que ja estao no chart
    if @cart.chart_offers.empty?
      @chart_offer = ChartOffer.create(offer_id: params[:offer_id], quantity: 1, chart_id: @cart.id)
    elsif @cart.chart_offers.pluck(:id) == (@chartoffers_tooked)
      @chart_offer = ChartOffer.find_by(id: @chartoffers_tooked)
      @chart_offer.quantity += 1
    else
      @chart_offer = ChartOffer.create(offer_id: params[:offer_id], quantity: 1, chart_id: @cart.id)
    end
    @cart.user = current_user if current_user # Se user ja estiver logado, ja atribui o cart para current_user, senao sera feito no checkout
    @cart.save
    if @chart_offer.save
      # Analisar aqui -> Pode ter mais de uma chartoffer?
      session[:chart_offer_id] = @chart_offer.id
      flash[:notice] = "Oferta adicionada!"
      redirect_to '/chart'
    else
      raise
      flash[:notice] = "Erro, nao foi possivel adicionar a oferta"
      redirect_to root_path
    end
  end

  def add
    @chart_offer = ChartOffer.find(params[:chart_offer_id])
    @chart_offer.quantity += 1
    @chart_offer.save
    redirect_to '/chart'
  end

  def remove
    @chart_offer = ChartOffer.find(params[:chart_offer_id])
    if @chart_offer.quantity > 1
      @chart_offer.quantity -= 1
    else
      flash[:notice] = "Quantidade minima, favor remover o produto do carrinho"
    end
    @chart_offer.save
    redirect_to '/chart'
  end

  private

  def chart_offer_params
    params.require(:chart_offer).permit(:offer_id)
  end
end
