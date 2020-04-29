Rails.application.routes.draw do

  get 'pages/home'
  get 'products/index'
  # root to index
  root to: 'pages#home'

  # Offers
  resources :offers, except: %i[ destroy ]
  resources :products, only: %i[ index ]

  # Stores
  resources :stores, except: %i[ destroy ]

  # Devise
  devise_for :users

  # Admin
  scope 'admin' do
    get '/dashboard', to: 'admin#dashboard'
    get '/offers', to: 'admin#offers', as: 'all_offers'
    get 'new_offer', to: 'admin#new_offer', as: 'new_offers'
    get 'new_store', to: 'admin#new_store', as: 'new_stores'
    get 'edit_offer', to: 'admin#edit_offer', as: 'audit_offer'
    get 'edit_store', to: 'admin#edit_store', as: 'audit_store'
  end

  #Cart
  post '/chart_offer/:offer_id', to: 'charts_offers#create', as: 'create_cart_offer'
  get '/chart', to: 'charts#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
