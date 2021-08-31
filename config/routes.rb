Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users
  root 'home#index'
end
