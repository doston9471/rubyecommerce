Rails.application.routes.draw do

  get 'carts/show'

  mount RailsAdmin::Engine => '/adminstrator', as: 'rails_admin'

  devise_for :admins
  root 'items#index'

  resources :items

  resource :cart, only: [:show] do
    put 'add/:item_id', to: 'carts#add', as: :add_to
    put 'remove/:item_id', to: 'carts#remove', as: :remove_from
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
