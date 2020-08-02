# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_admin, unless: :devise_controller?
  before_action :custom_param_devise, if: :devise_controller?
  before_action :set_cart
  # current_use already have a cart but put something on session cart before login
  after_action :get_session_cart, if: :user_buying_unsigned?

  def require_admin
    unless current_user&.admin
      flash[:notice] = 'Permissão negada. Favor logar como administrador.'
      redirect_to(root_path)
    end
  end

  def get_session_cart
    # get offers from session cart
    @cart.fill_cart(session)
  end

  # Cart methods
  def set_new_cart
    @cart = Cart.create
    # get offers from session cart when authentication happens
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
              # user already has a cart
              unless (params[:controller] == 'offers' && params[:action] == "show") || (params[:controller] == 'pages' && params[:action] == "home")
                Cart.includes(cart_offers: :offer).find(current_user.cart_id)
              else
                Cart.find(current_user.cart_id)
              end
            else
              # session already has a cart
              unless (params[:controller] == 'offers' && params[:action] == "show") || (params[:controller] == 'pages' && params[:action] == "home")
                Cart.includes(cart_offers: :offer).find(session[:cart_id])
              else
                Cart.find(session[:cart_id])
              end
              # current_user.cart_id = @cart.id if current_user
            end
  rescue ActiveRecord::RecordNotFound
    # if there is no cart, create a new one
    # session just started or user authentication for first time
    set_new_cart
  end

  def custom_param_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name birthdate])
  end

  def after_sign_in_path_for(resource)
    # raise
    if @_request.referer.match?(/checkout/)
      checkout_path
    else
      root_path
    end
  end

  # check if user has offers on session before authentication
  def user_buying_unsigned?
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      # if current and devise the user just logged
      # and only gets session cart, if there is cart_offers in it
      devise_controller? && current_user && cart&.cart_offers.present?
    else
      # if session has not cart_id, the user just logged out
      false
    end
  end

end
