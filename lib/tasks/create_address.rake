# frozen_string_literal: true

require 'correios-cep'

desc 'Add addresses to Stores'
task create_adresses: :environment do
  CEPS = %w[
    05027020 08226021 08226021 04236094
    03047000 08240001 08240001 01517100
    01034030 01253100 01253100 04005002
  ].freeze

  def create_sample_address
    cep = CEPS.sample
    address = Correios::CEP::AddressFinder.get(cep)
    Address.create!({
                      street: address[:address],
                      city: address[:city],
                      state: address[:state],
                      zipcode: address[:zipcode],
                      neighborhood: address[:neighborhood]
                    })
  end

  Store.where(address: nil).each do |store|
    address = create_sample_address
    puts "#{address.street} for #{store.comercial_name}" if store.update!(address: create_sample_address)
  end
end
