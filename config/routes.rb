# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  root 'homepage#index'
  resources :users, only: %i[index show], path: 'authors', as: 'authors'
  resources :subscriptions, only: %i[create destroy]
  resources :feeds, only: [:index]
  resources :posts, only: %i[new index show create] do
    resources :comments, only: %i[new create index]
  end
end
