Rails.application.routes.draw do
  resources :posts
  resources :users do
    member do
      patch :avatar
      patch :save_avatar
      patch :cover
      patch :save_cover
    end
  end
  resources :comments
  root to: 'blog#index'
  get     '/signup',              to: 'users#new'
  post    '/signup',              to: 'users#create'
  get     '/login',               to: 'blog#index'
  post    '/login',               to: 'sessions#create'
  delete  '/logout',              to: 'sessions#destroy'
  get     '/load_more',           to: 'posts#load_more'
  get     '/more_comment',        to: 'comments#more_comment'
  # get '*path' => redirect('/')
end
