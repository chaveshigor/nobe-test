Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'show_account', to: 'bank_account#show_account'
  resources :bank_account

  root 'bank_account#show_account'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
