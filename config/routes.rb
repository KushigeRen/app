Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/payments/:token/new', to: 'payments#new', as: 'payments_new'
  get '/group/:token', to: 'formats#show', as: 'group_show'
  post '/formats/register', to: 'formats#member_register', as: 'member_register'
  root 'formats#index'
  resources :payments, only: [:create, :edit, :update, :destroy]
  resources :formats do
    member do
      get 'edit_group'
      put 'update_group'
      get 'add_member'
      post 'create_member'
    end
  end
end
