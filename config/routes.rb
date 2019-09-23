Rails.application.routes.draw do
  devise_for :users
  get 'users/new'
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  resources :users
  
end
