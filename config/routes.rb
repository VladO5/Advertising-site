Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  get "/ads", to: "advertisements#index", as: :ads

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy", as: :logout

  get "/register", to: "users#new", as: :new_user
  post "/register", to: "users#create", as: :create_user
  get "/advertisements/:id/delete", to: "advertisements#delete", as: :delete_advertisement

  resources :advertisements

end
