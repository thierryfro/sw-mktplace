require 'rest-client'

class StoresController < ApplicationController

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
    @store.update(store_params)
    redirect_to store_path(@store)
  end

  # Ver com Bruno, acho que nao poderá deletar store
  def destroy
    @store.destroy
    redirect_to root_path
  end

  def credentials
    @store = Store.find_by(id: session[:store_id])

    url = "https://api.mercadopago.com/oauth/token"

    headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'accept': 'application/json'
    }
    body = {
      'client_secret': ENV["PROD_ACCESS_TOKEN"],
      'grant_type': "authorization_code",
      'code': "#{params[:code]}",
      'redirect_uri': "https://80765965a838.ngrok.io/credentials"
    }

    # Create the HTTP objects
    begin
        response = RestClient.post(url, body, headers)
      byebug
      if @store&.update(access_token: response[:access_token], public_key: response[:public_key], refresh_token: response[:refresh_token] )
        flash[:notice] = "Conta vinculada com sucesso"
        redirect_to store_path(@store)
      end
  rescue Exception => error
      flash[:notice] = error
      redirect_to store_path(@store) || root_path
      # Send the request
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :email, :cnpj, :comercial_name, :owner_id)
  end

  def set_store
    @store = Store.find(params[:id])
  end

  def set_store_with_id
    @store = Store.find(params[:store_id])
  end

end
