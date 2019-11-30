Rails.application.routes.draw do
 
  get 'comments/create'
  get 'comments/show'
  get 'comments/destroy'
  get 'comment/create'
  get 'comment/show'
  get 'comment/destroy'
  resources :pic_posts
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
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
  resources :posts, only: [:create, :destroy, :show]
  resources :comments, only: [:create, :destroy, :show]
  resources :likes, only: [:create, :destroy, :show]
  
end
