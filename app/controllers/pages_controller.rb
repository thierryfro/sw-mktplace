# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :address_params, only: [:new_address]
  skip_before_action :require_admin

  def home; end

  def new_address
    clean_session_address if session[:address_id].present?
    address = Address.new(@address_params)
    if address.save
      session[:address_id] = address.id
      @cart.update!(address: address)
      @cart.update_freight
      redirect_to offers_path
    else
      flash[:notice] = "Endereço inválido"
      render root_path
    end
  end

  private
  
  def clean_session_address
    address = Address.find_by(id: session[:address_id])
    session[:address] = nil
    @cart.update(address: nil)
    address.destroy if address && address.user_id.nil?
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
