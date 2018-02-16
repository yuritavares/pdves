Rails.application.routes.draw do
  root to: 'dves#index'
  resources :dves
end
