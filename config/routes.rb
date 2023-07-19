Rails.application.routes.draw do
  #get 'routes/index'
  #get 'routes/new'
  #get 'routes/create'
  #get 'routes/show'
  #get 'buses/new'
  #get 'buses/create'
  #get 'pages/about_us'
  #get 'pages/contact_us'
  #get 'pages/privacy_policy'
  #get 'pages/term_and_condition'
  
  devise_for :users
  root 'home#index'
  #get 'home/bus'
  get 'routes/index'
  resources :buses
  resources :routes 
 
  
  #get 'home/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
   
  # Defines the root path route ("/")
  #root "home#index"
end
