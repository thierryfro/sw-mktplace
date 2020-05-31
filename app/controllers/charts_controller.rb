require 'mercadopago.rb'

class ChartsController < ApplicationController

  skip_before_action :require_admin
  before_action :authenticate_user!, only: :checkout

  def show
    if current_user
      @cart = Chart.find(current_user.chart_id)
      @chart_offers = @cart.chart_offers
    else
      @chart_offers = ChartOffer.where(chart_id: session[:chart_id])
    end
  end

  # def session_offers(chart_offers)
  #   offers = []
  #   chart_offers.each do |offer|
  #     session_offers << offer
  #   end
  #   offers
  # end

  def checkout

    # Sem user chega o @cart == session[:chart_id]
    @session_cart = Chart.find(session[:chart_id])

    # Depois que authenticate, user tera outro cart, passar os produtos do cart_session pro cart_user
    unless @session_cart.chart_offers.empty?
      @cart.chart_offers.destroy_all
      @session_cart.chart_offers.each do |cart_offer|
        @cart.chart_offers << cart_offer
      end
    end

    # Começo da Order
    # Configura credenciais
    $mp = MercadoPago.new(ENV['PROD_ACCESS_TOKEN'])

    # Cria um objeto de preferência
    items = []
    @cart.chart_offers.each do |chart_offer|
      items << { title: chart_offer.offer.id, unit_price: chart_offer.offer.price, quantity: chart_offer.quantity }
    end
    preference_data = {
      "items": items
    }
    preference = $mp.create_preference(preference_data)

    # Este valor substituirá a string "<%= @preference_id %>" no seu HTML
    @preference_id = preference["response"]["id"]
  end
end
