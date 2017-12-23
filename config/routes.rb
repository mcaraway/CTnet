Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }, controllers: {
        sessions: 'users/sessions'
      }
  root to: 'application#home'
  
  get 'pages/main'
  get '/home', to: 'application#home', as: 'home'
  
  resources :shipments
  resources :stores
  resources :order_item_attributes
  resources :order_items
  resources :orders
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
