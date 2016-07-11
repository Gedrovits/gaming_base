Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }, path_names: { sign_up: 'register' }
  
  # Games
  resources :games
  
  # Roles
  resources :roles
  
  # Communities
  resources :communities do
    member do
      get :join
      get :leave
    end
  end
  
  # Team
  resources :teams do
    member do
      get :join
      get :leave
    end
    
    resources :games
  end
  
  # Gamers
  resources :gamers, only: [:index, :show, :edit, :update] do
    collection do
      get :search
      match :search_results, via: [:get, :post]
    end
    
    resources :communities
    resources :teams
  end
  
  resources :memberships do
    member do
      get :approve
      get :decline
      get :ban
      get :unban
      
      get :change_role
    end
  end
  
  authenticated(:user) do
    get '/', to: 'gamers#home', as: :user_root
    get '/gamer', to: 'gamers#gamer', as: :user_gamer
    post '/update_gamer', to: 'gamers#update_gamer', as: :user_update_gamer
    get '/my_games', to: 'users#games', as: :user_games
    
    # TODO: Move static pages outside authenticated block
    # Static pages
    get '/about', to: 'pages#about'
    get '/partners', to: 'pages#partners'
    get '/developers', to: 'pages#developers'
    
    # Legal stuff
    get '/terms-of-service', to: 'pages#terms_of_service'
    get '/privacy-policy', to: 'pages#privacy_policy'
    get '/cookie-policy', to: 'pages#cookie_policy'
    
    get '/kitchensink', to: 'pages#kitchensink'
    
    # TODO: THIS MUST BE CORRECTLY SECURED!!!
    resources :users
    match '/become_user/:id', to: 'users#become_user', as: :become_user, via: [:get, :post]
    match '/become_self', to: 'users#become_self', as: :become_self, via: [:get, :post]
    # TODO: THIS MUST BE CORRECTLY SECURED!!!
  end
  
  root 'pages#homepage'
end
