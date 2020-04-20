Rails.application.routes.draw do

  # root to index
  root to: 'offers#index'

  # Offers
  resources :offers, except: %i[ destroy ]
  get "/produtos", to: "offers#product_list"
  # Stores
  resources :stores, except: %i[ destroy ]

  # Devise
  devise_for :users

  # Admin
  scope 'admin' do
    get '/admins', to: 'admin#admins'
    get '/offers', to: 'admin#offers'

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
