Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/payments/:token/new', to: 'payments#new', as: 'payments_new'
  get '/group/:token', to: 'formats#show', as: 'group_show'
  # get '/formats/add', to: 'formats#add', as: 'member_add'
  # post '/formats/member', to: 'formats#create_member', as: 'member_create'
  # get '/formats/:id/edit/group', to: 'formats#edit_group', as: 'group_edit'
  # put '/formats/group', to: 'formats#update_group', as: 'group_update'
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
