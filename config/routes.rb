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
    post "approve", on: :member
   post "deny", on: :member
    resources :reviews, only: [:new, :create]
  end


  namespace :api do
    get 'dashboard' => 'dashboard', as: "dashboard", defaults: {format: :json} 
    resources :conversations, only: [:index, :show], defaults: {format: :json}
    resources :messages, only: [:index, :show, :create], defaults: {format: :json} 
    resources :reviews, only: [:index, :show, :create], defaults: {format: :json} 
    resources :listings, only: [:index, :show, :create], defaults: {format: :json} 
    resources :reservations, only: [:index, :show], defaults: {format: :json} 
    resources :users, only: [:show, :create], defaults: {format: :json}
    
    get 'myListings' => 'listings#myListings', as: "myListings", defaults: {format: :json} 
  end

  root 'static#home'
  
  get 'dashboard' => 'static#dashboard', as: "dashboard"
  
end
