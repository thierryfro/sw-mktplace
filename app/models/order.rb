require 'mercadopago.rb'
require 'pry'
class Order < ApplicationRecord
  belongs_to :store
  belongs_to :user
  belongs_to :address
  belongs_to :freight_rule

  def update_payment(response)
    # update payment with parsed response
    parsed_response = parse_mp_response(response)
    puts parsed_response
    update!(parsed_response)
    # update mp status
    update_mp_status if payment_status && payment_status_detail
    # if payment approved, collect fees
    update!(collect_fees(response)) if payment_status == 'approved'
  end

  def parse_mp_response(response)
    {
      payment_id: response['id'],
      collector_id: response['collector_id'],
      payment_status: response['status'],
      payment_status_detail: response['status_detail'],
      taxes_amount: response['taxes_amount'],
      installments: response['installments'],
      payment_type: response['payment_type_id'],
      transaction_amount: response['transaction_amount']
    }
  end

  def search_payment
    $mp = MercadoPago.new(store.access_token)
    response = $mp.get("/v1/payments/#{payment_id}")
    response['response']
  end

  # when approved collect fees infos
  def parse_fee(response, type)
    response['fee_details'].find { |fee| fee['type'] == type }['amount']
  end

  def collect_fees(response)
    {
      date_approved: response['date_approved'],
      mercadopago_fee: parse_fee(response, 'mercadopago_fee'),
      application_fee: parse_fee(response, 'application_fee')
    }
  end

  # payment statuses, more descriptive payment status
  def update_mp_status
    update(
      mp_response: MP_STATUSES[payment_status.to_sym][payment_status_detail.to_sym]
    )
  end

  MP_STATUSES = {
    "approved": {
      "accredited": 'Pronto, seu pagamento foi aprovado! No resumo, você verá a cobrança do valor como statement_descriptor.'
    },
    "in_process": {
      "pending_contingency": 'Estamos processando o pagamento. Não se preocupe, em menos de 2 dias úteis informaremos por e-mail se foi creditado.',
      "pending_review_manual": 'Estamos processando seu pagamento. Não se preocupe, em menos de 2 dias úteis informaremos por e-mail se foi creditado ou se necessitamos de mais informação.'
    },
    "rejected": {
      "cc_rejected_bad_filled_card_number":	'Revise o número do cartão.',
      "cc_rejected_bad_filled_date":	'Revise a data de vencimento.',
      "cc_rejected_bad_filled_other":	'Revise os dados.',
      "cc_rejected_bad_filled_security_code":	'Revise o código de segurança do cartão.',
      "cc_rejected_blacklist":	'Não pudemos processar seu pagamento.',
      "cc_rejected_call_for_authorize":	'Você deve autorizar ao payment_method_id o pagamento do valor ao Mercado Pago.',
      "cc_rejected_card_disabled":	'Ligue para o payment_method_id para ativar seu cartão. O telefone está no verso do seu cartão.',
      "cc_rejected_card_error":	'Não conseguimos processar seu pagamento.',
      "cc_rejected_duplicated_payment":	'Você já efetuou um pagamento com esse valor. Caso precise pagar novamente, utilize outro cartão ou outra forma de pagamento.',
      "cc_rejected_high_risk":	'Seu pagamento foi recusado. Escolha outra forma de pagamento. Recomendamos meios de pagamento em dinheiro.',
      "cc_rejected_insufficient_amount":	'O payment_method_id possui saldo insuficiente.',
      "cc_rejected_invalid_installments":	'O payment_method_id não processa pagamentos em installments parcelas.',
      "cc_rejected_max_attempts":	'Você atingiu o limite de tentativas permitido. Escolha outro cartão ou outra forma de pagamento.',
      "cc_rejected_other_reason":	'payment_method_id não processa o pagamento.'
    }
  }

end
