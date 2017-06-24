Rails.application.routes.draw do
  devise_for :users, only: [:sessions,:registrations]

  namespace :mypage do
    root 'favorite_images#index'
    resources :favorite_images, only: [:index, :show]
    resources :favorite_girls, execpt: [:show, :destroy]
  end

  namespace :admin do
    root 'top#index'
    get 'top' => 'top#index'
    resources :girl_settings, execpt: [:show]
  end

  resources :images, only: [:show]
  resources :girls, only: [:index, :show]
  resources :latest_images, only: [:index]
  resource :image_favorite, only: [:create, :destroy]

  root 'latest_images#index'
end
