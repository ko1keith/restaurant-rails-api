Rails.application.routes.draw do
  resource :accounts, only: [:create]
  post "/login", to: "accounts#login"
  get "/auto_login", to: "accounts#auto_login"

  resources :restaurants, only: [:index, :show, :create] do
    resources :orders
  end
end
