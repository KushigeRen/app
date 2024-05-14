Rails.application.routes.draw do
  post 'payments/create'
  get 'payments/update'
  get 'payments/destroy'
  get '/payments/:token', to: 'payments#new', as: 'payments_new'
  get '/group/:token', to: 'formats#show', as: 'group_show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'formats#index'
  resources :formats, only: [:index, :new, :create]
end
