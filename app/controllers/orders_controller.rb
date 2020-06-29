class OrdersController < ApplicationController
  skip_before_action :require_admin
  skip_before_action :verify_authenticity_token

  def create
    @order = Order.new(order_params)
    # @order = {
    #   preference_id: params[:preference_id],
    #   external_reference: params[:external_reference],
    #   back_url: params[:back_url],
    #   payment_id: params[:payment_id],
    #   payment_status: params[:payment_status],
    #   payment_status_detail: params[:payment_status_detail],
    #   merchant_order_id: params[:merchant_order_id],
    #   processing_mode: params[:processing_mode],
    #   merchant_account_id: params[:merchant_account_id]
    # }
    @order.user = current_user
    @order.address = current_user.address.first
    @order.store = @cart.cart_offers.first.store

    if @order.save!
      @cart.cart_offers.each { |cart_offer| OrderOffer.create(order: @order, offer: cart_offer.offer, recorded_value: cart_offer.offer.price)}
    end
    @cart.cart_offers.destroy_all


    puts "ORDER + #{@order}"
    redirect_to offers_path


  end

  def order_params
    params.permit(:preference_id, :payment_id, :payment_status, :payment_status_detail, :merchant_order_id, :processing_mode, :merchant_account_id)
  end

  # APROVADA1
  {
    :preference_id=>"558584930-adcfd115-d450-4bd4-8965-d9405f3d90a3",
    :external_reference=>"",
    :back_url=>"",
    :payment_id=>"25717816",
    :payment_status=>"approved",
    :payment_status_detail=>"accredited",
    :merchant_order_id=>"1329216722",
    :processing_mode=>"aggregator",
    :merchant_account_id=>""
  }

  # PAGAMENTO PENDENTE
  {
    :preference_id=>"558584930-89b428b8-ad31-49d9-98ca-9116ea0311f6",
    :external_reference=>"",
    :back_url=>"",
    :payment_id=>"25719320",
    :payment_status=>"in_process",
    :payment_status_detail=>"pending_contingency",
    :merchant_order_id=>"1329370816",
    :processing_mode=>"aggregator",
    :merchant_account_id=>""
  }


end
