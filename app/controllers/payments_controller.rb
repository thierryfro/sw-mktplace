# SDK de Mercado Pago
require 'mercadopago.rb'

class PaymentsController < ApplicationController
  skip_before_action :require_admin

  def mercado
    # Configura credenciais
    $mp = MercadoPago.new(ENV['PROD_ACCESS_TOKEN'])

    # Cria um objeto de preferência
    preference_data = {
      "items": [
        {
          "title": "Meu produto",
          "unit_price": 100,
          "quantity": 1
        }
      ]
    }
    preference = $mp.create_preference(preference_data)

    # Este valor substituirá a string "<%= @preference_id %>" no seu HTML
    @preference_id = preference["response"]["id"]
  end

end
