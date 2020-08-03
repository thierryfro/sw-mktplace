# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :address_params, only: [:new_address]
  before_action :set_address, only: :update
  skip_before_action :require_admin

  def new_address
    clean_session_address if session[:address_id].present?
    address = Address.new(@address_params)
    if address.save
      session[:address_id] = address.id
      @cart.update!(address: address)
      @cart.update_freight
    else
      flash[:notice] = "Endereço inválido"
    end
    redirect_to offers_path
  end

  def update
    @address.update(user_address_params)
    render json: @address
  end

  private

  def set_address
    @address = Address.find_by(id: params[:id])
  end

  def user_address_params
    params.require(:address).permit(
      :street, :number, :neighborhood, :city, :state, :zipcode, :complement
    )
  end

  def address_params
    @address_params = params.require(:address).permit(:info, :zipcode, :city, :street)
    @address_params = parse_params
  end

  def parse_params
    {
      street: @address_params[:street],
      zipcode: @address_params[:zipcode].gsub('-', ''),
      city: @address_params[:city]
    }
  end
end
