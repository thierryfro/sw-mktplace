class ApplicationController < ActionController::Base

  before_action :require_admin, unless: :devise_controller?
  before_action :custom_param_devise, if: :devise_controller?
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
    current_user.chart_id = @cart.id if current_user
    session[:chart_id] = @cart.id
  end

  def set_cart
    if current_user
      @cart = Chart.find(current_user.chart_id)
    else
      @cart = Chart.find(session[:chart_id])
    # current_user.chart_id = @cart.id if current_user
    end
  rescue ActiveRecord::RecordNotFound
    set_new_cart
  end

  def custom_param_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthdate])
  end
end
