require 'mercadopago.rb'

class OrdersController < ApplicationController
  skip_before_action :require_admin
  before_action :authenticate_user!, only: :payment

  def new
    @store = @cart.store
    @amount = @cart.calc_subtotal + @cart.freight_rule.price
    @store = @cart.store
    @quantity = @cart.count_items
  end

  def create
    response = call_mp_api
    parsed_response = manage_payment(response)
    @order = Order.new(parsed_response)
    if @order.save
      @cart.cart_offers.clear
      redirect_to order_path(@order)
    else
      flash.now[:alert] = 'Something went wrong'
      render 'new'
    end
  end
  
  def sucess; end
  
  private
  
  def call_mp_api
    $mp = MercadoPago.new(@cart.store.access_token)
    response = $mp.post('/v1/payments', payment_data)
    if response['status'] != '201'
      raise
      flash.now[:alert] = 'Something went wrong'
      render 'new'
    end
    response['response']
  end

  def manage_payment(response)
    {
      user: current_user,
      store: @cart.store,
      address: @cart.address,
      freight_rule: @cart.freight_rule,
      payment_id: response['id'],
      payment_status: response['status'],
      payment_status_detail: response['status_detail'],
      payment_type: response['payment_type_id'],
      installments: response['installments'],
      taxes_amount: response['taxes_amount'],
      mercadopago_fee: response['fee_details'].first['amount'],
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
      "binary_mode": true,
      "application_fee": amount.fdiv(10).round(2),
      "statement_descriptor": "Suplemento Rapido",
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
