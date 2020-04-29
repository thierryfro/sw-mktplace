class ChartsController < ApplicationController

  def show
    @chart_offers = ChartOffer.all
  end
end
