class OffersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def offer_params
    params.require(:offer).permit(:store_id, :stock, :price, :active)
  end
end
