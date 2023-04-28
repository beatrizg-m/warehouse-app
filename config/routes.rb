Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  get 'warehouses/:id/confirmar_exclusao', to: 'warehouses#confirmar_exclusao', as: 'confirmar_exclusao'
end
