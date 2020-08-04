require 'mercadopago.rb'

class Order < ApplicationRecord
  belongs_to :store
  belongs_to :user
  belongs_to :address
  belongs_to :freight_rule

  def check_payment
    $mp = MercadoPago.new(store.access_token)
    response = $mp.get("/v1/payments/#{payment_id}")
  end
end
