Rails.application.routes.draw do
  resources :articles
  resources :animals
  devise_for :users, controllers: {registrations: "users/registrations"}

  root to: "pages#index"

  get "/home", to: "pages#home", as: "user_home"
  get "/account", to: "pages#account", as: "user_account"
  get "/contact", to: "pages#contact", as: "contact"
  get "/admin-dashboard", to: "pages#admin", as: "admin"
  get "/admin-view/:id", to: "pages#admin_view_user", as: "admin_user"
  post "/admin-approve/:id", to: "pages#admin_approve_user", as: "admin_user_approve"
  post "/admin-deny/:id", to: "pages#admin_deny_user", as: "admin_user_deny"
  post "/animals/media/:id", to: "animals#media_add", as: "animals_media"
  delete "/animals/media/:id", to: "animals#media_delete"
  post "/animals/new_message/:id", to: "animals#new_message", as: "new_message"
  get "/payments/success", to: "payments#success", as: "payment_success"
  post "/payments/webhook", to: "payments#webhook", as: "webhook"
  post "/payments", to: "payments#create_payment_intent", as: "create_payment"
end
