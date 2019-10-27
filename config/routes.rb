Rails.application.routes.draw do
  resources :users, only: [:index, :create]
  resources :sessions, only: [:index, :create]

  get 'monsters/:offset', to: 'monsters#index'
  #resources :monsters, only: [:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
