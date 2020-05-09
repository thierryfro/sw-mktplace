class StoresController < ApplicationController

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin

  def index
    if current_user && current_user.admin?
      @stores = Store.all
    else
      @stores = Store.where(owner_id: current_user)
    end
  end

  def show
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

  private

  def store_params
    params.require(:store).permit(:name, :email, :cnpj, :comercial_name, :owner_id)
  end

  def set_store
    @store = Store.find(params[:id])
  end

end
