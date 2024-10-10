Rails.application.routes.draw do
  root to: 'homes#top'
  resources :books, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  devise_for :users, controllers: {
  sessions: 'users/sessions'
  }
  get 'home/about', to: 'homes#about', as: 'about'
  resources :users
end
