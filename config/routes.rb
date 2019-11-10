Rails.application.routes.draw do
  resources :wallets, only: [:index]
  resources :users, only: [:index, :create]
  resources :sessions, only: [:index, :create]
  resources :parties, only: [:index, :update]

  get 'items/:offset', to: 'items#index'
  
  get 'monsters/:offset', to: 'monsters#index'
  #resources :monsters, only: [:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
