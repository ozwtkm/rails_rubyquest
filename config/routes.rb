Rails.application.routes.draw do
  get 'sessions/create'
  resources :users, only: [:index, :create]
  resources :sessions, only: [:index, :create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
