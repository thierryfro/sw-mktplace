# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/home'
  get 'products/index'
  get 'payments/mercado'
  post 'procesar-pago', to: 'orders#create' # retorno de pagamento do mercado pago ( DEVE SER ALTERADA PARA A PAGINA DE RESPOSTA )
  # root to index
  root to: 'pages#home'
  post 'start_address', to: 'pages#new_address', as: 'start_address'

  # Offers
  resources :offers, except: %i[destroy]
  resources :products, only: %i[index]

  # Stores
  resources :stores, except: %i[ destroy ]

  # Address
  resources :address, except: :destroy

  # Users
  resources :users, only: :update

  get 'stores/:store_id/offers', to: 'offers#store', as: 'store_offers'

  get 'credentials', to: 'stores#credentials'
  # post 'credential_new', to: "stores#credential_new"

  # Devise
  devise_for :users

  scope 'profile' do
    get '/info', to: 'profile#info', as: 'user_info'
    get '/addresses', to: 'profile#addresses', as: 'user_addresses'
  end

  # Admin
  scope 'admin' do
    patch '/admin', to: 'admin#edit_profile', as: 'edit_profile'
    get '/profile', to:'admin#profile', as: 'admin_profile'
    get '/dashboard', to: 'admin#dashboard'
    get '/offers', to: 'admin#offers', as: 'all_offers'
    get 'new_offer', to: 'admin#new_offer', as: 'new_offers'
    get 'edit_offer', to: 'admin#edit_offer', as: 'audit_offer'
    get 'new_store', to: 'admin#new_store', as: 'new_stores'
    get 'edit_store', to: 'admin#edit_store', as: 'audit_store'
  end

  # Cart
  post '/cart_offer/:offer_id', to: 'carts_offers#create', as: 'create_cart_offer'
  get '/cart', to: 'carts#show'
  post '/checkout', to: 'carts#checkout'
  get '/sucess', to: 'carts#sucess'
  post '/cart/:cart_offer_id/add', to: 'carts_offers#add', as: 'add_cart'
  post '/cart/:cart_offer_id/decrease', to: 'carts_offers#remove', as: 'decrease_cart'
  resources :carts_offers, only: %i[destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Payments
  get '/payment', to: 'carts#payment', as: 'payment'
end
