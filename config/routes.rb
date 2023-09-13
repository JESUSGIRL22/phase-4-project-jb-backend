Rails.application.routes.draw do
  get 'applications/new'
  get 'applications/create'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'jobs/index'
  get 'jobs/new'
  get 'jobs/create'
  get 'jobs/show'
  get 'jobs/destroy'
  get 'users/new'
  get 'users/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
