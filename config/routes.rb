Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users, only:[:show, :new, :create, :edit, :update, :destroy]
  resources :sessions, only:[:new, :create,:destroy]
  namespace :admin do
    resources :users
  end
end
