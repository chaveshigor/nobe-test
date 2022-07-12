module TransactionServices
  class CreateTransactionService
    OPERATIONS = {
      DRAW: TransactionServices::DrawMoneyService.new,
      DEPOSIT: TransactionServices::DepositMoneyService.new,
      SEND: TransactionServices::SendMoneyService.new
    }.freeze

    def initialize(transaction_params)
      @transaction_params = transaction_params
    end

    attr_reader :transaction_params

    def run
      transaction_type = transaction_params[:transaction_type]
      transaction_type = Transaction.transaction_types.key(transaction_type.to_i).to_sym
      transaction_params[:transaction_type] = transaction_type

      OPERATIONS[transaction_type].run(transaction_params)
    end
  end
end
