module TransactionServices
  class CalculateBalanceService
    def initialize(current_transaction, current_balance)
      @current_transaction = current_transaction
      @transaction_types = Transaction.all_transaction_types
      @current_balance = current_balance
    end

    attr_reader :current_transaction, :transaction_types, :current_balance

    def run
      calculate_balance
    end

    private

    def calculate_balance
      fee = calculate_fee
      current_type = current_transaction.transaction_type.to_sym
      operation = transaction_types[current_type][:operation]
      amount = current_transaction.amount
      total_cust = amount + fee

      result = current_balance + operation * total_cust
      return false if result.negative?

      [result, fee]
    end

    def calculate_fee
      current_week_day = Time.zone.today.wday
      current_hour = Time.zone.now.hour

      fee = 7
      fee = 5 if current_week_day <= 5 && current_hour.between?(9, 18)
      fee += 10 if current_transaction.amount > 1000

      fee
    end
  end
end
