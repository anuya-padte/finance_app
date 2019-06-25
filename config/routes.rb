Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  get      '/summary',   to: 'home#summary'
  get      '/category',    to: 'categories#add_category'

  resources :transactions
  resources :categories,          only: [:create, :destroy]
  resources :incomes, controller: 'transactions', type: 'Income'
  resources :expenses, controller: 'transactions', type: 'Expense'
end
