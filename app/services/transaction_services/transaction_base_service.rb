module TransactionServices
  class TransactionBaseService
    def error_response(error_message)
      { success: false, message: error_message }
    end

    def success_response(transaction)
      { success: true, transaction: transaction }
    end

    def calculate_fee(amount)
      current_week_day = Time.zone.today.wday
      current_hour = Time.zone.now.hour

      fee = current_week_day <= 5 && current_hour.between?(9, 18) ? 5 : 7
      fee += 10 if amount > 1000

      fee
    end

    def calculate_balance(amount, current_balance, operation)
      fee = calculate_fee(amount)
      total_cust = amount + fee * operation

      current_balance + total_cust
    end
  end
end
