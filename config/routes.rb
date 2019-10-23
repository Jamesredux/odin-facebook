Rails.application.routes.draw do
 
  devise_for :users, controllers: { registrations: 'users/registrations' }
  #get 'users/new' not sure why this is here or if it is neeeded??
  root 'static_pages#home'

  
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  #get 'requests/sent', to: 'requests#sent'
  
  resources :users
  resources :friendships
  resources :requests do
    collection do 
      get :sent
    end  
  end  
  resources :posts, only: [:create, :destroy]
  
end
