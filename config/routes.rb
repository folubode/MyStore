Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

#routes
 root 'pages#index'
 get 'shop' => 'pages#shop'
 get 'about' => 'pages#about'

 resources :carts
 resources :product_items
 resources :orders
 resources :contacts, only: [:new, :create]
 
end
