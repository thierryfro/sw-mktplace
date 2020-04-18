class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.search_products(params[:query]).order(:name).page params[:page]
    else
      @products = Product.order(:name).page params[:page]
    end
  end
end
