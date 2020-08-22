Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users, only: [:index, :new, :create, :show]
  resources :posts, only: [:index, :new, :create, :destroy]
end
