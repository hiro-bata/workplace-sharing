Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users, only: [:index, :new, :create, :show] do
    delete :destroy, on: :member
  end
  
  resources :posts, only: [:index, :new, :create, :destroy] do
    get :search, on: :collection
  end
  
  resources :favorites, only: [:create, :destroy]
end
