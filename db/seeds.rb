# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


if Rails.env == 'development'

  puts ''
  puts "Environment #{Rails.env}"
  puts "Iniciando o seed"
  puts ''

  # create users
  puts "Criando o usuário"
  User.destroy_all
  hugo = User.create!(email: 'hugo@sw.com', name: 'Hugo', last_name: 'Branquinho', password: 'swpass', birthdate: DateTime.now - 33.years, admin: true)
  thierry = User.create!(email: 'thierry@sw.com', name: 'Thierry', last_name: 'Fernando', password: 'swpass', birthdate: DateTime.now - 34.years, admin: true)
  bruno = User.create!(email: 'bruno@sw.com', name: 'Bruno', last_name: 'Tostes', password: 'swpass', birthdate: DateTime.now - 50.years, admin: true)
  manoel = User.create!(email: 'manoel@sw.com', name: 'Manoel', last_name: 'Tabet', password: 'swpass', birthdate: DateTime.now - 40.years )
  puts "Usuários: #{User.count}"
  puts ""

  # create stores
  puts "Criando stores"
  Store.destroy_all
  vendinha = Store.create!(name: 'Vendinha', email: 'vendinha@bomba.com', cnpj: '16.453.309/0001-77', comercial_name: 'Vendinha Ltda', owner: hugo)
  budega = Store.create!(name: 'Budega', email: 'budega@bomba.com', cnpj: '24.655.223/0001-55', comercial_name: 'Budega Ltda', owner: thierry)
  marombas = Store.create!(name: 'Marombas', email: 'marombas@bomba.com', cnpj: '00.660.772/0001-50', comercial_name: 'Marombas Ltda', owner: bruno)
  savewhey = Store.create!(name: 'Savewhey', email: 'savewhey@bomba.com', cnpj: '97.491.634/0001-26', comercial_name: 'Marombas Ltda', owner: manoel)
  puts "Stores: #{Store.count}"
  puts ""

  # create freight zones
  puts 'Criando Zonas de frete'
  FreightZone.destroy_all
  FreightZone.create!(zone: 'Sul', store: vendinha)
  FreightZone.create!(zone: 'Oeste', store: vendinha)
  FreightZone.create!(zone: 'Norte', store: vendinha)

  FreightZone.create!(zone: 'Norte', store: budega)
  FreightZone.create!(zone: 'Leste', store: budega)

  FreightZone.create!(zone: 'Leste', store: marombas)
  FreightZone.create!(zone: 'Sul', store: marombas)

  FreightZone.create!(zone: 'Norte', store: savewhey)

  puts "Zonas de frete #{FreightZone.count}"
  puts ""

  # criando freight rules
  puts "Criando regras de frete"
  zones = FreightZone.last(4)
  FreightRule.destroy_all
  FreightRule.create!(limit_price: 120.00, discount: 20, store: vendinha)
  zones.each do |zone|
    FreightRule.create!(limit_price: 100.00, discount: 20, freight_zone: zone)
  end
  puts "Regras de frete criadas #{FreightZone.count}"
  puts ''

  # cleaning products section

  puts "Products antigos #{Product.count}"
  puts "Brands antigos #{Brand.count}"
  puts "Categories antigos #{Category.count}"
  puts "Subcategories antigos #{Subcategory.count}"
  puts ""

  Brand.destroy_all
  puts "Products #{Product.count}"
  puts "Brands #{Brand.count}"

  Category.destroy_all
  puts "Categories #{Category.count}"

  Subcategory.destroy_all
  puts "Subcategories #{Subcategory.count}"
  puts ''

  # create products section
  puts "Criando sessão de produtos"

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
    OfferProduct.create(offer: offer, product: products.sample) if rand(100) < 50
  end

  20.times do
    offer = Offer.create!(store: budega, stock: 50, price: 60.00, active: true)
    OfferProduct.create(offer: offer, product: products.sample)
    OfferProduct.create(offer: offer, product: products.sample) if rand(100) < 50
  end

  20.times do
    offer = Offer.create!(store: marombas, stock: 20, price: 120.00, active: true)
    OfferProduct.create(offer: offer, product: products.sample)
    OfferProduct.create(offer: offer, product: products.sample) if rand(100) < 50
  end

  puts "Offers #{Offer.count}"
  puts "Offer Products #{OfferProduct.count}"

  puts "End of seed"

end
