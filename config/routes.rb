Rails.application.routes.draw do
  root 'jobs#index'

  # Define routes for Sessions (Login/Logout)
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Define routes for Users
  resources :users, only: [:new, :create]

  # Define routes for Jobs
  resources :jobs, except: [:destroy] # You may not need a destroy action for jobs

  # Define routes for Applications
  resources :applications, only: [:new, :create]

  # You can remove the manual get routes for jobs, as they are covered by resources :jobs above.

  # Other routes go here if needed...

end
