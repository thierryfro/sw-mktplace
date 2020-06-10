# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_admin, unless: :devise_controller?
  before_action :custom_param_devise, if: :devise_controller?
  before_action :set_cart
  after_action :get_session_cart, if: lambda {
                                        devise_controller? &&
                                          session[:cart_id] &&
                                          current_user
                                      }

  def require_admin
    unless current_user&.admin
      flash[:notice] = 'Permissão negada. Favor logar como administrador.'
      redirect_to(root_path)
    end
  end

  def get_session_cart
    # current_use already have a cart but put something on session cart before login
    @cart.fill_cart(session) 
  end
  
  # Cart methods
  def set_new_cart
    @cart = Cart.create 
    # get offers from session chart when authentication happens
    # if current_user has no cart - his cart is created for the first time
    if current_user
      get_session_cart
      current_user&.update(cart_id: @cart.id)
    end
    # the session cart is set
    session[:cart_id] = @cart.id
  end

  def set_cart
    @cart = if current_user
              Cart.find(current_user.cart_id)
            else
              Cart.find(session[:cart_id])
              # current_user.cart_id = @cart.id if current_user
            end
  rescue ActiveRecord::RecordNotFound
    set_new_cart
  end

  def custom_param_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name birthdate])
  end
end
