Rails.application.routes.draw do
  root to: "toppages#index"
  
  resources :users, only: [:index, :new, :create]
end
