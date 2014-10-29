Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :edit, :update, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :listings do
    resources :reservations, only: :index
  end
  resources :reservations, only: [:create, :destroy] do 
    resources :reviews, only: [:new, :create]
  end

  root 'listings#index'
end
