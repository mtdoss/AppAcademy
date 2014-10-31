Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests do
    post "approve", on: :member
    post "deny", on: :member
  end
  resources :users, only: [:index, :new, :create]
  resource :session, only: [:new, :destroy, :create]
end
