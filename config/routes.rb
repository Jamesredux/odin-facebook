Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'users/new'
  root 'static_pages#home'

  
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  resources :users
  
end
