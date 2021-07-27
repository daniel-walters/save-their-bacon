Rails.application.routes.draw do
  resources :animals
  devise_for :users, controllers: {registrations: "users/registrations"}

  root to: "pages#index"

  get "/home", to: "pages#home", as: "user_home"
  get "/account", to: "pages#account", as: "user_account"
  get "/contact", to: "pages#contact", as: "contact"
  get "/admin-dashboard", to: "pages#admin", as: "admin"
  get "/admin-view/:id", to: "pages#admin_view_user", as: "admin_user"
  post "/admin-view/:id", to: "pages#admin_approve_user"
end
