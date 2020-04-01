class StoresController < ApplicationController

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

  def store_params
    params.require(:store).permit(:name, :email, :cnpj, :comercial_name, :owner_id)
  end

end
