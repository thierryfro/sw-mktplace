require 'mercadopago.rb'

class ChartsController < ApplicationController

  skip_before_action :require_admin
  before_action :authenticate_user!, only: :checkout

  def show
    if current_user
      @cart = Chart.find_by(user_id: current_user)
      @chart_offers = @cart.chart_offers
    else
      @chart_offers = ChartOffer.where(chart_id: session[:chart_id])
    end
  end

  def checkout
    # Atribuir user ao cart
    @cart.update(user: current_user) if @cart.user.nil?
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
