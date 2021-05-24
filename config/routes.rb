# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :statements
  get '/index', to: 'dashboard#index', as: :welcome
  get '/deposit', to: 'dashboard#deposit', as: :deposit
  get '/cashWithdrawal', to: 'dashboard#cash_withdrawal', as: :cash_withdrawal
  get '/fundTransfer', to: 'dashboard#fund_transfer', as: :fund_transfer
  get '/balanceInquiry', to: 'dashboard#balance_inquiry', as: :balance_inquiry
  get '/financialStatement', to: 'dashboard#financial_statement', as: :financial_statement
  get '/financialByPeriod', to: 'dashboard#financial_by_period', as: :financial_by_period
  get '/cancelAccount', to: 'registrations#cancel_account', as: :cancel_account
  post '/createDeposit', to: 'dashboard#create_deposit', as: :create_deposit
  post '/createWithdrawal', to: 'dashboard#create_withdrawal', as: :create_withdrawal
  post '/createFundTransfer', to: 'dashboard#create_fund_transfer', as: :create_fund_transfer
  root to: 'dashboard#index'
end
