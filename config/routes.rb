Rails.application.routes.draw do
 	#  resources :virtualtours
  resources :posts
  resources :panoramas
  match '/page', to: 'pages#index', via: [:get]
 devise_for :users  #,   controllers: { omniauth_callbacks: "authentication" }
 resources :users, :only => [:show]
 root 'posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
