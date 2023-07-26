Rails.application.routes.draw do
  
  
  get 'pages/about_us'
  get 'pages/contact_us'
  get 'pages/privacy_policy'
  get 'pages/term_and_condition'
   get "my_tickets", to: "users#my_tickets"
  get "cancelled_tickets", to: "tickets#cancelled_tickets"
  devise_for :users
  resources :tickets
  root "routes#index"
  #get 'home/bus'
  #get 'routes/index'
  resources :buses do
    resources :tickets do
       get "approve_ticket"
      get "reject_ticket"
      get "cancel_ticket"
    end
  end
  resources :routes
   resources :buses do
    collection do
      get 'search'
    end

  end
  
  resources :schedules
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
   
  # Defines the root path route ("/")
  
end
