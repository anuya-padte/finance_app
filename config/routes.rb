Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  get     '/total',    to: 'home#total'
  resources :transactions
  resources :incomes, controller: 'transactions', type: 'Income'
  resources :expenses, controller: 'transactions', type: 'Expense'
end
