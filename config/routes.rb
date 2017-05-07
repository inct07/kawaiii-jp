Rails.application.routes.draw do
  devise_for :users, only: [:sessions,:registrations]

  scope :mypage do
    get 'favorites(/:girl_id)' => 'mypage#favorites', as: :mypage_favorites
  end

  namespace :admin do
    root 'top#index'
    get 'top' => 'top#index'
    resources :girl_settings, execpt: [:show]
  end

  resources :girls, only: [:index, :show]
  resources :images, only: [:index]
  resource :favorite, only: [:create, :destroy]

  root 'girls#index'
end
