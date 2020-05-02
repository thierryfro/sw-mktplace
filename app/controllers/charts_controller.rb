class ChartsController < ApplicationController

  skip_before_action :require_admin
  before_action :authenticate_user!, only: :checkout

  def show
    if current_user
      @cart = Chart.where(user_id: current_user)
      @chart_offers = ChartOffer.where(chart_id: @cart)
    else
      @chart_offers = ChartOffer.where(chart_id: session[:chart_id])
    end
  end

  def checkout
    # Atribuir user ao cart
    @cart.user = current_user if @cart.user.nil?
    # Começo da Order
  end
end
