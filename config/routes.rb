Rails.application.routes.draw do
  resources :animals
  devise_for :users

  root to: "pages#index"

  get "/home", to: "pages#home", as: "user_home"
  get "/account", to: "pages#account", as: "user_account"
  get "/contact", to: "pages#contact", as: "contact"
end
