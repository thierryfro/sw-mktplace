class ChartsOffersController < ApplicationController


  def create
    @chart_offer = ChartOffer.create(chart_offer_params)
    @chart_offer.quantity = 0
    @chart_offer.chart = @cart
    if @chart_offer.save?
      redirect_to 'charts#show'
      raise
    else
      flash[:notice] = "Erro, nao foi possivel adicionar a oferta"
      redirect_to root_path
      raise
    end
  end

  private

  def chart_offer_params
    params.require(:chart_offer).permit(:offer_id)
  end
end
