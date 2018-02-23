Rails.application.routes.draw do
  resources :restconnections
  resources :dbconnections
  resources :fulfillment_bills
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }, controllers: {
        sessions: 'users/sessions'
      }
  root to: 'application#home'
  
  get 'pages/main'
  get '/home', to: 'application#home', as: 'home'
  get '/dashboard', to: 'application#dashboard', as: 'dashboard'
  get '/billing', to: 'application#billing', as: 'billing'
  get '/app_settings', to: 'application#app_settings', as: 'app_settings'
  
  resources :shipments
  resources :stores
  resources :order_item_attributes
  resources :order_items
  resources :orders 
  resources :users
  resources :parts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :charts do
    get 'orders/:store_id', to: 'charts#orders'
    get 'items_by_week'
    get 'orders_by_week'
    get 'parts'
  end
end
