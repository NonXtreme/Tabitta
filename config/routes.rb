Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets do
    resources :likes, module: :tweets, only: [:create, :destroy]
    resources :retweets, module: :tweets, only: [:new, :create]
    resources :replies, module: :tweets, only: [:new, :create]
  end

  root 'tweets#index'
end
