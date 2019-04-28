Rails.application.routes.draw do
  resources :production_events
  resources :production_lines
  resources :sales_orders
  resources :estimates
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
  get '/refresh_bill/:id', to: 'fulfillment_bills#refresh', as: 'refresh_bill'
  get '/create_sales_order/:id', to: 'fulfillment_bills#create_sales_order', as: 'create_sales_order'
  get '/create_xlsx/:id', to: 'fulfillment_bills#create_xlsx', as: 'create_xlsx'
  get '/production_data', to: 'production_lines#data', as: 'production_data'
  post '/production_events/build/:id', to: 'production_events#build', as: 'production_events_build'
  put '/production_events/update_ajax/:id', to: 'production_events#update_ajax', as: 'production_events_update_ajax'
  get '/schedules', to: 'production_events#schedules', as: 'schedules'
  
  resources :shipments
  resources :stores
  resources :order_item_attributes
  resources :order_items
  resources :orders 
  resources :users
  resources :parts
  resources :manufacturing_orders
  resources :inventory
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :charts do
    get 'orders/:store_id', to: 'charts#orders'
    get 'items_by_week', to: '#items_by_week', as: 'items_by_week'
    get 'orders_by_week', to: '#orders_by_week', as: 'orders_by_week'
    get 'parts'
  end
end
