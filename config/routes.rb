Rails.application.routes.draw do



  devise_for :users
  get 'welcome/index'
  get 'welcome/about'
  get '/welcome' => "users#show", as: :user_root
  root 'welcome#index'
  resources :users
  put 'user/downgrade' => "users#downgrade"
  resources :wikis do
    resources :collaborators
  end
  

  resources :charges, only: [:new, :create]
end
