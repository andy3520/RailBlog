Rails.application.routes.draw do
  resources :posts
  resources :users
  root to: 'blog#index'
  get     '/signup',     to: 'users#new'
  post    '/signup',     to: 'users#create'
  get     '/login',      to: 'blog#index'
  post    '/login',      to: 'sessions#create'
  delete  '/logout',     to: 'sessions#destroy'
  # get '*path' => redirect('/')
end
