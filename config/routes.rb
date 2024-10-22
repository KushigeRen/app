Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/payments/:token/new', to: 'payments#new', as: 'payments_new'
  get "/create_event/:id", to: "calendars#create_event", as: "create_event"
  get "/oauth2callback", to: "calendars#handle_oauth_callback"
  get '/group/:token', to: 'formats#show', as: 'group_show'
  post '/formats/register', to: 'formats#member_register', as: 'member_register'
  root 'formats#index'
  resources :payments, only: [:create, :edit, :update, :destroy]
  delete 'destroy_selected', to: 'payments#destroy_selected', as: :delete_payments
  resources :formats do
    member do
      get 'edit_group'
      put 'update_group'
      get 'add_member'
      post 'create_member'
    end
  end
end
