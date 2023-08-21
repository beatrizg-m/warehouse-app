Rails.application.routes.draw do
  devise_for :user
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  get 'warehouses/:id/confirmar_exclusao', to: 'warehouses#confirmar_exclusao', as: 'confirmar_exclusao'
  resources :suppliers, only: [:index, :new, :create, :show, :edit, :update]
  resources :product_models, only:[:index, :new, :create, :show]

  resources :orders, only:[:new, :create, :show, :index, :edit, :update] do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member

  end

end
