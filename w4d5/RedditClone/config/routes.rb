Rails.application.routes.draw do
  resources :users
  resource :session
  resources :subs do
    resources :posts, only: [:new]
  end
  resources :posts, except: [:index, :destroy]
 end
