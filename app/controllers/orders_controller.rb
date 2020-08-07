require 'mercadopago.rb'

class OrdersController < ApplicationController
  skip_before_action :require_admin
  protect_from_forgery with: :null_session, only: %i[webhook]
  skip_before_action :verify_authenticity_token, only: %i[webhook]
  before_action :authenticate_user!, only: %i[payment]

  def new; end

  def create
    init_order
    begin
      response = process_payment
      @order.update_payment(response)
      manage_response(response)
    rescue StandardError => e
      puts e
      # @order.destroy
      raise
      flash.now[:alert] = 'Algo deu errado com a tentativa de pagamento'
      render :new
    end
  end

  def sucess; end

  def webhook
    begin
      @order = Order.find_by(id: params[:id])
      response = @order.search_payment
      @order.update_payment(response)
    rescue StandardError => e
      puts e
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

  def process_payment
    $mp = MercadoPago.new(@cart.store.access_token)
    response = $mp.post('/v1/payments', payment_data)
    response['response']
  end

  def manage_response(response)
    if @order.payment_status.match?(/(approved|in_process)/)
      @order.create_order_offers(@cart)
      @cart.cart_offers.clear
      redirect_to order_path(@order)
    else
      @order.destroy
      response['message']
      flash.now[:alert] = response['message']
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
      "application_fee": amount.fdiv(20).round(2),
      "statement_descriptor": 'Suplemento Rapido',
      "notification_url": "https://e8c67b18d410.ngrok.io/orders/#{@order.id}/webhook",
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
