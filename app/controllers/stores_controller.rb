class StoresController < ApplicationController

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin

  def index
    @stores = Store.all
  end

  def show
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    # if current_user && current_user.admin?
    #   @store.owner = params[:owner_id]
    # else
    #   @store.owner = current_user
    # end
    unless current_user && current_user.admin?
      @store.owner = current_user
      raise
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
  end

  def update
    @store.update(store_params)
    redirect_to store_path(@store)
  end

  def destroy
    @store.destroy
    redirect_to root_path
  end

  private

  def store_params
    params.require(:store).permit(:name, :email, :cnpj, :comercial_name, :owner_id)
  end

  def set_store
    @store = Store.find(params[:id])
  end

end
