class ChartsController < ApplicationController

  skip_before_action :require_admin
  before_action :authenticate_user!, only: :checkout

  def show
    if current_user
      @cart = Chart.where(user_id: current_user).first
      @chart_offers = ChartOffer.where(chart_id: @cart)
    else
      @cart = Chart.find(session[:chart_id])
      @chart_offers = ChartOffer.where(chart_id: session[:chart_id])
    end
    @freight = @cart.freight_rule
  end

  def checkout
    # Atribuir user ao cart
    @cart.user = current_user if @cart.user.nil?
    # Começo da Order
  end
end
