Rails.application.routes.draw do
  resources :supervisors

  devise_for :users, controllers: { registrations: "users/registrations" }
  root 'static_pages#home'
  get 'static_pages/home'
  get '/index', to: 'static_pages#index'
end
