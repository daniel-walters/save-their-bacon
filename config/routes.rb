Rails.application.routes.draw do
  devise_for :users

  root to: "pages#index"

  get "/home", to: "pages#home", as: "user_home"
  get "/account", to: "pages#account", as: "user_account"
end
