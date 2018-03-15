Rails.application.routes.draw do
  root to: 'dves#index'
  resources :dves

  get 'month_detail', :to => 'dves#month_detail'
end
