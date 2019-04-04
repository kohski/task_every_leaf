Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users,only:[:show,:new,:create,:edit,:update,:destroy]
end
