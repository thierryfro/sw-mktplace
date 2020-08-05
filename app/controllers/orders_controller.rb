require 'mercadopago.rb'
require 'json'
require 'pry'

class OrdersController < ApplicationController
  skip_before_action :require_admin
  protect_from_forgery with: :null_session, only: %i[webhook]
  skip_before_action :verify_authenticity_token, only: %i[webhook]
  before_action :authenticate_user!, only: %i[payment]

  def new
    @amount = @cart.calc_subtotal + @cart.freight_rule.price
    @quantity = @cart.count_items
  end

  def create
    @order = Order.create(
      user: current_user,
      store: @cart.store,
      address: @cart.address,
      freight_rule: @cart.freight_rule
    )
    response = call_mp_api
    parsed_response = manage_payment(response) if response
    if parsed_response && @order.update(parsed_response)
      @cart.cart_offers.clear
      redirect_to order_path(@order)
    else
      flash.now[:alert] = 'Something went wrong'
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

  def call_mp_api
    $mp = MercadoPago.new(@cart.store.access_token)
    response = $mp.post('/v1/payments', payment_data)
    return false if response['status'] != '201'

    response['response']
  end

  def manage_payment(response)
    {
      payment_id: response['id'],
      payment_status: response['status'],
      payment_status_detail: response['status_detail'],
      payment_type: response['payment_type_id'],
      installments: response['installments'],
      taxes_amount: response['taxes_amount'],
      mercadopago_fee: (response['fee_details']&.first&['amount']) || 0,
      collector_id: response['collector_id']
    }
  end

  def payment_data
    amount = payment_params['transaction_amount'].to_i
    {
      "transaction_amount": amount,
      "token": payment_params['token'],
      "description": payment_params['description'],
      "installments": payment_params['installments'].to_i,
      "application_fee": amount.fdiv(10).round(2),
      "statement_descriptor": 'Suplemento Rapido',
      "notification_url": "http://localhost:3000/orders/#{@order.id}/webhook",
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

  def webhook_params
    params.permit(
      :id, :live_mode, :type, :date_created, :application_id,
      :user_id, :version, :api_version, :action, :data
    )
  end
end
