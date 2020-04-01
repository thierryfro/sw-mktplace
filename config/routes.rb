Rails.application.routes.draw do

  # Offers
  resources :offers

  # Stores
  resources :stores

  # Devise
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
