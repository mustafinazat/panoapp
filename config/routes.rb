Rails.application.routes.draw do
	
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :articles
  resources :virtualtours do
    member do
    get 'embed'
    end
  end
  resources :posts
  resources :pages, :only => [:show]
  resources :panoramas, :only => [:show,:destroy]
  resources :faqs, :only => [:index, :create,:destroy]
   match '/about', to: 'pages#about', via: [:get]
  match '/flickr', to: 'pages#flickr', via: [:get]
 devise_for :users  #,   controllers: { omniauth_callbacks: "authentication" }
 resources :users, :only => [:show]
  resources :users do
    resources :posts,  :only => [:index], to: 'posts#userposts'
  end
  resources :users do
    resources :virtualtours,  :only => [:index],  to: 'virtualtours#uservts'
  end
  resources :tags, :only => [:show,:index, :destroy]
 root 'posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
