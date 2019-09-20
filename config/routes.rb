Rails.application.routes.draw do
  devise_for :users
  get 'users/new'
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
