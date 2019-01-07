Rails.application.routes.draw do
  root to: 'home#index'

  get 'mypage', to: 'home#show'
  get 'pay',    to: 'home#pay'
  get 'qrcode', to: 'home#qrcode'

  resources :orders, only: [:create]

  get  'signup', to: 'users#new'
  post 'signup', to: 'user#create'

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
