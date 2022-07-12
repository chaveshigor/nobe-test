module TransactionServices
  class CalculateBalanceService
    def initialize(transaction_type, amount, current_balance)
      @transaction_type = transaction_type.to_sym
      @amount = amount
      @transaction_types = Transaction.all_transaction_types
      @current_balance = current_balance
    end

    attr_reader :transaction_type, :amount, :transaction_types, :current_balance

    def run
      calculate_balance
    end

    private

    def calculate_balance
      fee = calculate_fee
      operation = transaction_types[transaction_type][:operation]
      total_cust = amount + fee

      result = current_balance + operation * total_cust

      [result, fee]
    end

    def calculate_fee
      current_week_day = Time.zone.today.wday
      current_hour = Time.zone.now.hour

      fee = current_week_day <= 5 && current_hour.between?(9, 18) ? 5 : 7
      fee += 10 if amount > 1000

      fee
    end
  end
end
