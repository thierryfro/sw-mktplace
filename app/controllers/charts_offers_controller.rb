class ChartsOffersController < ApplicationController

  skip_before_action :require_admin


  def create
    # @chart_offer = @cart.chart_offers.empty? ? ChartOffer.create(offer_id: params[:offer_id], quantity: 1, chart_id: @cart.id) : ChartOffer.find_by(chart_id: @cart.id)
    @chartoffers_tooked = ChartOffer.where(offer_id: params[:offer_id], chart_id: @cart.id).pluck(:id) # Offer que ja estao no chart
    if @cart.chart_offers.empty?
      @chart_offer = ChartOffer.create(offer_id: params[:offer_id], quantity: 1, chart_id: @cart.id)
    elsif @cart.chart_offers.pluck(:id) == (@chartoffers_tooked)
      @chart_offer = ChartOffer.find_by(id: @chartoffers_tooked)
      @chart_offer.quantity += 1
    else
      @chart_offer = ChartOffer.create(offer_id: params[:offer_id], quantity: 1, chart_id: @cart.id)
      # @chart_offer = ChartOffer.find(params[:offer_id])
      # @chart_offer = ChartOffer.find_by(chart_id: @cart.id)
    end
    # if @cart.chart_offers.pluck(:id) == (@chartoffers_tooked)
    #   @chart_offer.quantity += 1
    # end
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

  private

  def chart_offer_params
    params.require(:chart_offer).permit(:offer_id)
  end
end
