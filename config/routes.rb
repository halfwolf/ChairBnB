Rails.application.routes.draw do
  
  resources :users, only: [:index, :new, :create, :edit, :update, :show] do
    resources :messages, only: [:new, :create]
  end
  resources :messages, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  
  resources :listings do
    resources :reservations, only: :index
  end
  
  resources :reservations, only: [:create, :destroy] do 
    resources :reviews, only: [:new, :create]
  end

  root 'static#home'
  
  get 'dashboard' => 'static#dashboard', as: "dashboard"
  
end
