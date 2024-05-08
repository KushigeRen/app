Rails.application.routes.draw do
  get '/group/:token', to: 'formats#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'formats#index'
  resources :formats, only: [:index, :new, :create]
end
