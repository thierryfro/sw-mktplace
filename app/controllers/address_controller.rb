class AddressController < ApplicationController

  before_action :set_address, only: :update


  def create
  end

  def update
    @address.update(address_params)
    render json: @address
  end

  private

  def set_address
    @address = Address.find_by(id: params[:id])
  end

  def address_params
    params.require(:address).permit(
      :street, :number, :neighborhood, :city, :state, :zipcode, :complement
    )
  end
end
