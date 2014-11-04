Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new, :index]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]
  resources :notes
end