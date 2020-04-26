Rails.application.routes.draw do

  get 'products/index'
  # root to index
  root to: 'offers#index'

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
