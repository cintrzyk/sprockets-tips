Rails.application.routes.draw do
  root to: 'posts#index'

  # devise_for :users

  resources :posts

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  mount Alchemy::Engine => '/'
end
