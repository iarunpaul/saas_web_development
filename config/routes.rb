Rails.application.routes.draw do
 
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :users do
  resource :profile
end

  resources :users do
    member do
      get :confirm_email
    end
  end
  
  get 'about', to: 'pages#about'
  resources :contacts, only: [:create]
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
