Rails.application.routes.draw do
  resources :signup, only: [:new, :create]
  # resources :sessions
  resources :home


  resources :users, only: [:create, :show] do
    resources :uploads
  end
  # get "/register", to: "signup#new"
  # get "/signup", to: "signup#create"
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"


  root "home#index"
end
