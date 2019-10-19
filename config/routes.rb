Rails.application.routes.draw do
  get 'tasks/index'
  resources :users, only: [:index, :create]
  resources :sessions, only: [:index, :create]
  resources :monsters, only: [:index]
  resources :tasks, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
