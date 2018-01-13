Rails.application.routes.draw do
  resources :authors
  resources :poems
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'poems#index'
end
