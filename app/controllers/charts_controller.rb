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

  # def session_offers
  #   # Guardas as ofertas escolhidas no cart da session
  #   session_offers = []
  #   @cart.chart_offers do |offer|
  #     session_offers << offer
  #   end
  # end

  def checkout
    # Atribuir user ao cart
    current_user.chart_id = @cart.id if current_user.chart_id.nil?
    # Passar as ofertas da session pro cart
    if @cart
      current_user.cart.cart_offers.destroy_all # limpa o carrinho velho
      @cart.cart_offers.each{ |cart_offer| cart_offer.cart = current_user.cart } # muda os produtos para o carrinho certo
    end
    # @car.chart_offers = session_offers()
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
