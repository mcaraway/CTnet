Rails.application.routes.draw do
  resources :shipments
  resources :stores
  resources :order_item_attributes
  resources :order_items
  resources :users
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
