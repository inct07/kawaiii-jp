Rails.application.routes.draw do
  devise_for :users, only: [:sessions,:registrations]
  resources :images, only: [:index]
  root 'images#index'
end
