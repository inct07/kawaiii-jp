Rails.application.routes.draw do
  devise_for :users, only: [:sessions,:registrations]
  resources :girls, only: [:index, :show]
  resources :images, only: [:index]

  root 'girls#index'
end
