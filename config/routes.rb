# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  root 'homepage#index'
end
