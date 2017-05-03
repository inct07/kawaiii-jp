Rails.application.routes.draw do
  devise_for :users
  resources :images, only: [:index]
  root 'images#index'
end
