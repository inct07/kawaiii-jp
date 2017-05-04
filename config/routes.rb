Rails.application.routes.draw do
  devise_for :users, only: [:sessions,:registrations]

  scope :mypage do
    get 'favorites' => 'mypage#favorites', as: :mypage_favorites
  end
  resources :girls, only: [:index, :show]
  resources :images, only: [:index]

  root 'girls#index'
end
