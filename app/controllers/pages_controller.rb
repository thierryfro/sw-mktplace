require 'via_cep'

class PagesController < ApplicationController
  skip_before_action :require_admin
  def home
  end

  def new_address
    
    raise
  end

  private

  def address_params
    params.require(:address).permit(:info, :zipcode, :street)
  end
end
