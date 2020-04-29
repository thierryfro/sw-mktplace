class ChartsController < ApplicationController

  skip_before_action :require_admin

  def show
    @chart_offers = ChartOffer.all
    raise
  end
end
