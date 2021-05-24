# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    ''
  end

  def deposit
    ''
  end

  def create_deposit
    value = (params[:user][:value]).to_i
    deposit = FinancialService.update_user_balance(value, current_user)
    respond_to do |format|
      if deposit
        format.html { redirect_to root_path, notice: "O deposito no valor de #{value} foi realizado com sucesso." }
      else
        format.html { redirect_to root_path, notice: 'Falha ao realizar o deposito.' }
      end
    end
  end

  def cash_withdrawal
    ''
  end

  def create_withdrawal
    value = (params[:user][:value]).to_i
    deposit = FinancialService.withdrawal(value, current_user)
    respond_to do |format|
      if deposit
        format.html { redirect_to root_path, notice: "O saque no valor de #{value} foi realizado com sucesso." }
      else
        format.html { redirect_to root_path, notice: 'Falha ao realizar o saque. Verifique-se se você tem esse valor disponível no saldo.' }
      end
    end
  end

  def fund_transfer
    ''
  end

  def create_fund_transfer
    value = (params[:user][:value]).to_i
    target_user = (params[:user][:target_user]).to_i
    
    deposit = FinancialService.fund_transfer(value, current_user, target_user)
    respond_to do |format|
      if deposit
        format.html { redirect_to root_path, notice: "A transferência no valor de #{value} foi realizado com sucesso." }
      else
        format.html { redirect_to root_path, notice: 'Falha ao realizar a transferência.
        Verifique-se se você tem esse valor disponível no saldo. Funcinamento de segunda a sexta-feira.' }
      end
    end
  end

  def balance_inquiry
    ''
  end

  def financial_statement
    ''
  end

  def financial_by_period
    start_date = params[:user][:start_date]
    end_date = params[:user][:end_date]
    @reports = FinancialService.search_by_period(current_user, start_date, end_date)
  end
end
