Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets, only: [:index, :create, :show, :destroy] do
    resources :likes, module: :tweets, only: [:create, :destroy]
    resources :retweets, module: :tweets, only: [:new, :create]
    resources :replies, module: :tweets, only: [:create]
  end
  resources :hashtags, only: [:show]
  resources :users do
    resources :followings, module: :users, only: [:create, :destroy]
  end

  root 'tweets#index'
end
