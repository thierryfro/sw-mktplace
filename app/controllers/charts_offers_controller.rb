class ChartsOffersController < ApplicationController

  skip_before_action :require_admin


  def create
    @chart_offer = ChartOffer.create(offer_id: params[:offer_id])
    @chart_offer.quantity = 0
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
