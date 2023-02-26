# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#dashboard'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :people do
    resources :emails, execpt: %i[show]
    resources :phone_numbers, execpt: %i[show]
    resources :addresses
  end

  resources :users, only: %i[create new]
end
