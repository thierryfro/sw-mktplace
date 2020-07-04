# frozen_string_literal: true

module StoresHelper
  def validate_address_infos(request_info)
    return {} if request_info[:zipcode].blank?

    cep = request_info[:zipcode].gsub('-', '')
    api_info = Correios::CEP::AddressFinder.get(cep)
    {
      id: request_info[:id],
      street: api_info[:address],
      city: api_info[:city],
      state: api_info[:state],
      zipcode: api_info[:zipcode],
      neighborhood: api_info[:neighborhood]
    }
  end
end
