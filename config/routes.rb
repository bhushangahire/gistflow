Gistflow::Application.routes.draw do
  match '/auth/:provider/callback' => 'users#create'
  match '/login' => 'sessions#create' if Rails.env.development?
  match '/logout' => 'sessions#destroy'
  
  resources :posts do
    get :like, :on => :member
    get :add_to_favorites, :on => :member
  end
  
  resources :notifications, :only => :index
  
  resources :users, :only => :show do
    resources :gists, :only => :index
  end
  
  resources :articles, 
    :only => [:index, :show], 
    :controller => :posts, 
    :type => 'Article'
  resources :questions,
    :only => [:index, :show], 
    :controller => :posts, 
    :type => 'Question'
  resources :community, 
    :only => [:index, :show], 
    :controller => :posts, 
    :type => 'Community'
  resources :tags, :only => :show
  root to: 'posts#index'
end
