Rails.application.routes.draw do
  # post 'payments/create'
  # patch 'payments/:id/update'
  # get 'payments/destroy'
  get '/payments/:token/new', to: 'payments#new', as: 'payments_new'
  # get '/payments/:id/edit', to: 'payments#edit', as: 'payments_edit'
  get '/group/:token', to: 'formats#show', as: 'group_show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'formats#index'
  resources :payments, only: [:create, :edit, :update, :destroy]
  resources :formats, only: [:index, :new, :create]
end
