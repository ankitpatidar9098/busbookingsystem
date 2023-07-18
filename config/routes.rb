Rails.application.routes.draw do
  
  devise_for :users
  get 'home/index'
  #get 'home/bus'
  #get 'home/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
   
  # Defines the root path route ("/")
  #root "home#index"
end
