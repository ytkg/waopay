Rails.application.routes.draw do
  root to: 'home#index'
  get 'mypage', to: 'home#show'

  resources :users, only: [:new, :create]

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
