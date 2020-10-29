Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'stock_price_requests#new'

  resources :stock_price_requests, only: [:new, :create]
end
