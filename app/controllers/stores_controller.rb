require 'rest-client'

class StoresController < ApplicationController
  include StoresHelper

  before_action :set_store, only: %i[show edit update destroy]
  # before_action :set_store_with_id, only: %i[credentials]
  skip_before_action :require_admin

  def index
    if current_user && current_user.admin?
      @stores = Store.all
    else
      @stores = Store.where(owner_id: current_user)
    end
  end

  def show
    session[:store_id] = @store.id
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    unless current_user && current_user.admin?
      @store.owner = current_user
    end
    if @store.save
      redirect_to @store
      flash[:notice] = "Loja criada com sucesso!"
    else
      render :new
      flash[:notice] = "Algo errado não está certo!"
    end
  end

  def edit
    unless @store.owner != current_user || current_user.admin?
      flash[:notice] = "Você não tem permissão para fazer isso!"
      redirect_to root_path
    end
  end

  def update
    current_params = store_params
    address_infos = helpers.validate_address_infos(current_params[:address_attributes])
    if address_infos.present?
      current_params[:address_attributes] = address_infos
      @store.update!(current_params)
      redirect_to admin_profile_path
    else
      flash[:notice] = "É preciso inserir um cep válido para continuar"
      redirect_to admin_profile_path
    end
  end

  # Ver com Bruno, acho que nao poderá deletar store
  # def destroy
  #   @store.destroy
  #   redirect_to root_path
  # end

  def credentials
    @store = Store.find_by(id: session[:store_id])
    # raise
    # code = 'TG-5ef766e061480e00074feedd-558584930'

    url = "https://api.mercadopago.com/oauth/token"

    headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'accept': 'application/json'
    }
    body = {
      # 'client_secret': ENV["PROD_ACCESS_TOKEN"],
      'client_secret': ENV["MP_ATOKEN"],
      'grant_type': "authorization_code",
      # 'code': "#{code}",
      'code': "#{params[:code]}",
      'redirect_uri': "https://e57193d67bac.ngrok.io/credentials"
    }
    # Create the HTTP objects
    begin
        response = RestClient.post(url, body, headers)
        response = JSON.parse(response)
      if @store&.update!(access_token: response[:access_token], public_key: response[:public_key], refresh_token: response[:refresh_token] )
        flash[:notice] = "Conta vinculada com sucesso"
        redirect_to stores_path(@store)
      end
  rescue Exception => error
      flash[:notice] = error
      redirect_to store_path(@store) || root_path
      # Send the request
    end
  end

  private

  def store_params
    params.require(:store).permit(
      :name, :email, :cnpj, :comercial_name, :owner_id,
      address_attributes: [:id, :zipcode, :number, :complement]
    )
  end

  def set_store
    @store = Store.find(params[:id])
  end

  def set_store_with_id
    @store = Store.find(params[:store_id])
  end

end
