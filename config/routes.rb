Rails.application.routes.draw do
  resources :shifts, only: [:index, :create, :new, :destroy, :update]
  devise_for :users
  root to: 'shifts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
