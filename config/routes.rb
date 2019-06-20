Rails.application.routes.draw do
  devise_for :users
  root 'home#home'

  resources :transactions
  resources :incomes, controller: 'transactions', type: 'Income'
  resources :expenses, controller: 'transactions', type: 'Expense'
end
