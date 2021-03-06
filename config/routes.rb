Rails.application.routes.draw do
  devise_for :users
  resources :courses do 
    resources :lessons
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/activity'
  root 'home#index'
end
