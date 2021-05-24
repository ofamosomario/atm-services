# frozen_string_literal: true

class FinancialService
  class << self
    include FinancialConstants

    def update_user_balance(value, current_user)
      total = current_user.balance + value
      if current_user.update_attribute(:balance, total)
        ReportService.new_register(value, current_user, 'DEPÓSITO')
        true
      else
        false
      end
    end

    def withdrawal(value, current_user)
      total = current_user.balance - value
      if (total >= MINIMUM_BALANCE) && current_user.update_attribute(:balance, total)
        ReportService.new_register(value, current_user, 'SAQUE')
        true
      else
        false
      end
    end

    def fund_transfer(value, current_user, target_user)
      fee = (value > MORE_THAN_THOUSAND ? THOUSAND_FEE : FEE_NONE)  
      today = Date.today
      time = Time.now.strftime('%H:%M:%S')
      balance_regular_tax = (current_user.balance - value) - REGULAR_TAX_FEE + fee
      balance_extra_tax = (current_user.balance - value) - EXTRA_TAX_FEE + fee
      user_to_transfer = User.find(target_user)
      total = user_to_transfer.balance + value
      current_user_total = current_user.balance - value

      if !today.saturday? || !today.sunday?
        if time >= '09:00:00' && time <= '18:00:00'
          if ((current_user_total - (REGULAR_TAX_FEE + fee)) >= MINIMUM_BALANCE) && current_user.update_attribute(:balance, balance_regular_tax)
            user_to_transfer.update_attribute(:balance, total)
            ReportService.new_register(value, current_user, 'TRANSFERÊNCIA')
            true
          else
            false
          end
        else
          if ((current_user_total - (EXTRA_TAX_FEE + fee)) >= MINIMUM_BALANCE) && current_user.update_attribute(:balance, balance_extra_tax)
            user_to_transfer.update_attribute(:balance, total)
            ReportService.new_register(value, current_user, 'TRANSFERÊNCIA')
            true
          else
            false
          end
        end
      else
        false
      end
    end

    def search_by_period(current_user, start_date, end_date)
      current_user.statements.by_period(start_date, end_date)
    end
  end
end
