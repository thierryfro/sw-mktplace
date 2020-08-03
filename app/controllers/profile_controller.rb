class ProfileController < ApplicationController
  layout 'admin_layout'

  def new_address
    address = Address.new(new_address_params)
    address.user = current_user
    if address.valid?
      address.save
      clean_session_address if session[:address_id].present?
      session[:address_id] = address.id
      @cart.update!(address: address)
      @cart.update_freight
      redirect_to user_addresses_path
    else
      flash[:notice] = "Endereço inválido"
    end
  end

  def info
  end

  def addresses
    @new_address = Address.new(user: current_user)
  end

  private

  def user_address_params
    params.require(:address).permit(
      :street, :number, :neighborhood, :city, :state, :zipcode, :complement
    )
  end

  def new_address_params
    params.require('/profile/addresses').permit(
      :street, :number, :neighborhood, :city, :state, :zipcode, :complement
    )
  end
end
