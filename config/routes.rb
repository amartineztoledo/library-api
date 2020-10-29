# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books
  resources :users
  resources :loans, only: :create
  resources :returns, only: :create
end
