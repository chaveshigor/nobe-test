Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'show_account', to: 'bank_account#show_account'
  resources :transactions
  put 'change_account_status', to: 'bank_account#change_bank_account_status'

  root 'bank_account#show_account'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
