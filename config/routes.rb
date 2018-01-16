Rails.application.routes.draw do
	
  resources :articles
  get 'tags/show'

  resources :virtualtours
  resources :posts
  resources :panoramas, :only => [:show,:destroy]
  resources :faqs, :only => [:index, :create,:destroy]
   match '/about', to: 'pages#about', via: [:get]
 devise_for :users  #,   controllers: { omniauth_callbacks: "authentication" }
 resources :users, :only => [:show]
  resources :tags, :only => [:show,:index, :destroy]
 root 'posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
