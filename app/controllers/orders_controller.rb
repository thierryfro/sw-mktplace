require 'mercadopago.rb'
require 'json'
require 'pry'

class OrdersController < ApplicationController
  skip_before_action :require_admin
  protect_from_forgery with: :null_session, only: %i[webhook]
  skip_before_action :verify_authenticity_token, only: %i[webhook]
  before_action :authenticate_user!, only: %i[payment]

  def new
  end

  def create
    init_order
    response = call_mp_api
    begin      
      parsed_response = helpers.parse_response(response)
      @order.update!(parsed_response)
      manage_response(response)
    rescue => exception
      @order.destroy
      flash.now[:alert] = "Something went wrong with payment try"
      render :new
    end
  end

  def sucess; end

  def webhook
    begin
      @order = Order.find_by(id: params[:id])
      binding.pry
    rescue Exception => e
      render json: { status: 400, error: 'Webhook failed' } and return
    end
    render json: { status: 200, message: 'OK' }
  end

  private

  def init_order
    @order = Order.create(
      user: current_user,
      store: @cart.store,
      address: @cart.address,
      freight_rule: @cart.freight_rule
    )
  end

  def call_mp_api
    $mp = MercadoPago.new(@cart.store.access_token)
    response = $mp.post('/v1/payments', payment_data)
    response['response']
  end

  def manage_response(response)
    case @order.payment_status
    when 'approved'
      @order.update(collect_fees(response))
      @cart.cart_offers.clear
      redirect_to order_path(@order)
    when 'in_process'
      @cart.cart_offers.clear
      redirect_to order_path(@order)
    when 'rejected'
      puts @order.response
      flash.now[:alert] = @order.mp_response
      render :new
    end
  end

  def payment_data
    amount = payment_params['transaction_amount'].to_f.round(2)
    {
      "transaction_amount": amount,
      "token": payment_params['token'],
      "description": payment_params['description'],
      "installments": payment_params['installments'].to_i,
      "application_fee": amount.fdiv(5).round(2),
      "statement_descriptor": 'Suplemento Rapido',
      "notification_url": "https://67f0bdef32eb.ngrok.io/orders/#{@order.id}/webhook",
      "payment_method_id": payment_params['payment_method_id'],
      "payer": {
        "email": payment_params['email']
      },
      "additional_info": {
        "items": @cart.payment_items
      }
    }
  end

  def payment_params
    params.permit(
      :transaction_amount, :token, :description,
      :installments, :payment_method_id, :email,
      :authenticity_token
    )
  end
end
