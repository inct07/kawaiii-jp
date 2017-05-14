Rails.application.routes.draw do
  devise_for :users, only: [:sessions,:registrations]

  namespace :mypage do
    root 'favorite_images#index'
    resources :favorite_images, only: [:index, :show]
    resources :favorite_girls, only: [:index]
  end

  namespace :admin do
    root 'top#index'
    get 'top' => 'top#index'
    resources :girl_settings, execpt: [:show]
  end

  resources :girls, only: [:index, :show]
  resources :images, only: [:index]
  resource :image_favorite, only: [:create, :destroy]

  root 'girls#index'
end
