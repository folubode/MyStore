Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

#routes
 root 'pages#index'
 get 'shop' => 'pages#shop'

 
end
