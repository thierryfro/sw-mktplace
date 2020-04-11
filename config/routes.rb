Rails.application.routes.draw do

  # root to index
  root to: 'offers#index'

  # Offers
  resources :offers, except: %i[ destroy ]

  # Stores
  resources :stores, except: %i[ destroy ]

  # Devise
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
