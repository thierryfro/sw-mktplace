# frozen_string_literal: true

require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

if Rails.env == 'development'

  puts ''
  puts "Environment #{Rails.env}"
  puts 'Iniciando o seed'
  puts ''

  # create users
  puts 'Criando o usuário'
  User.destroy_all
  hugo = User.create!(email: 'hugo@sw.com', name: 'Hugo', last_name: 'Branquinho', password: 'swpass', birthdate: DateTime.now - 33.years, admin: true)
  thierry = User.create!(email: 'thierry@sw.com', name: 'Thierry', last_name: 'Fernando', password: 'swpass', birthdate: DateTime.now - 34.years, admin: true)
  bruno = User.create!(email: 'bruno@sw.com', name: 'Bruno', last_name: 'Tostes', password: 'swpass', birthdate: DateTime.now - 50.years, admin: true)
  manoel = User.create!(email: 'manoel@sw.com', name: 'Manoel', last_name: 'Tabet', password: 'swpass', birthdate: DateTime.now - 40.years)
  puts "Usuários: #{User.count}"
  puts ''

  # create stores
  puts 'Criando stores'
  Store.destroy_all
  vendinha = Store.create!(name: 'Vendinha', email: 'vendinha@bomba.com', cnpj: '16.453.309/0001-77', comercial_name: 'Vendinha Ltda', owner: hugo)
  budega = Store.create!(name: 'Budega', email: 'budega@bomba.com', cnpj: '24.655.223/0001-55', comercial_name: 'Budega Ltda', owner: thierry)
  marombas = Store.create!(name: 'Marombas', email: 'marombas@bomba.com', cnpj: '00.660.772/0001-50', comercial_name: 'Marombas Ltda', owner: bruno)
  savewhey = Store.create!(name: 'Savewhey', email: 'savewhey@bomba.com', cnpj: '97.491.634/0001-26', comercial_name: 'Marombas Ltda', owner: manoel)
  puts "Stores: #{Store.count}"
  puts ''

  # creating freight rules
  puts 'Criando regras de frete'
  csv_options = { col_sep: ',', headers: :first_row }
  filepath    = File.dirname(__FILE__) + '/range_ceps.csv'
  zip_code_zones = []
  district_pattern = /\A[A-ZÃÕÁÓÉÍÚÂÊÇ]+(\s(E|DO))?(\s[A-ZÃÕÁÓÍÉÚÂÊÇ]+)?/
  CSV.foreach(filepath, csv_options) do |row|
    zip_code_zones << {
      name: row['Zona'],
      district: row['Bairros'].match(district_pattern).to_s.strip,
      start_zip_code: "#{row['Start_Code']}000",
      end_zip_code: "#{row['End_Code']}999"
    }
  end

  Store.all.each do |store|
    freights = [
      {
        name: 'Jato',
        freight_weight_attributes: {
          min_weight: 0,
          max_weight: 1000
        }
      },
      {
        name: 'Semi',
        freight_weight_attributes: {
          min_weight: 1000,
          max_weight: 3000
        }
      },
      {
        name: 'Pesado',
        freight_weight_attributes: {
          min_weight: 3000,
          max_weight: 100_000
        }
      }
    ]
    store_shipping_zones = zip_code_zones.sample(rand(5..15))
    freights.each_with_index do |freight, index|
      freight.merge!({
                       store: store,
                       price: (index + 1) * 5,
                       zip_code_zones_attributes: store_shipping_zones
                     })
      FreightRule.create!(freight)
    end
  end

  # cleaning products section

  puts "Products antigos #{Product.count}"
  puts "Brands antigos #{Brand.count}"
  puts "Categories antigos #{Category.count}"
  puts "Subcategories antigos #{Subcategory.count}"
  puts ''

  Brand.destroy_all
  puts "Products #{Product.count}"
  puts "Brands #{Brand.count}"

  Category.destroy_all
  puts "Categories #{Category.count}"

  Subcategory.destroy_all
  puts "Subcategories #{Subcategory.count}"
  puts ''

  # create products section
  puts 'Criando sessão de produtos'

  Rake::Task['seed_product_db'].invoke
  puts "Brands #{Brand.count}"
  puts ''
  puts "Categories #{Category.count}"
  puts ''
  puts "Subcategories #{Subcategory.count}"
  puts ''
  puts "Products #{Product.count}"
  puts ''
  puts "Product photos #{ProductPhoto.count}"
  puts ''

  # create offers
  puts 'Criando ofertas'
  Offer.destroy_all

  products = Product.all

  20.times do
    offer = Offer.create!(store: vendinha, stock: 40, price: 80.00, active: true)
    OfferProduct.create(offer: offer, product: products.sample)
    if rand(100) < 50
      OfferProduct.create(offer: offer, product: products.sample)
    end
  end

  20.times do
    offer = Offer.create!(store: budega, stock: 50, price: 60.00, active: true)
    OfferProduct.create(offer: offer, product: products.sample)
    if rand(100) < 50
      OfferProduct.create(offer: offer, product: products.sample)
    end
  end

  20.times do
    offer = Offer.create!(store: marombas, stock: 20, price: 120.00, active: true)
    OfferProduct.create(offer: offer, product: products.sample)
    if rand(100) < 50
      OfferProduct.create(offer: offer, product: products.sample)
    end
  end

  puts "Offers #{Offer.count}"
  puts "Offer Products #{OfferProduct.count}"

  puts 'End of seed'

end
