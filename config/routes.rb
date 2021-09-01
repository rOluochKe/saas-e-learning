Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]
  resources :lessons
  get 'home/activity'
  root 'home#index'
end
