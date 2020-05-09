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
  def set_new_cart
    @cart = Chart.create
    @cart.update(user: current_user) if current_user
    session[:chart_id] = @cart.id
  end

  def set_cart
    @cart = Chart.find(session[:chart_id])
    @cart.update(user: current_user) if @cart&.user.nil? && current_user
  rescue ActiveRecord::RecordNotFound
    set_new_cart
  end
end
