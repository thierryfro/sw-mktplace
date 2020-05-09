class ApplicationController < ActionController::Base

  before_action :require_admin, unless: :devise_controller?
  before_action :set_cart

  def require_admin
    unless current_user && current_user.admin
      flash[:notice] = "Permissão negada. Favor logar como administrador."
      redirect_to(root_path)
    end
  end

  # Cart methods
  def set_user_cart(cart)
    if current_user
      # cart.user = current_user
    end
  end

  def set_new_cart
    @cart = Chart.create
    session[:chart_id] = @cart.id
  end

  def set_cart
    @cart = Chart.find(session[:chart_id])
    if @cart.user.nil?
      set_user_cart(@cart)
    end
  rescue ActiveRecord::RecordNotFound
    set_new_cart
  end
end
