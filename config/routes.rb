Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }

  root to: "homes#top"

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy]

  resources :users, only: [:show, :index, :edit, :update]

  get '/home/about' => "homes#about", as: "about"

  resources :users
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
