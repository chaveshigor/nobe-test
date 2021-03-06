module TransactionServices
  class CreateTransactionService < TransactionBaseService
    OPERATIONS = {
      DRAW: TransactionServices::DrawMoneyService,
      DEPOSIT: TransactionServices::DepositMoneyService,
      SEND: TransactionServices::SendMoneyService
    }.freeze
    def initialize(transaction_params)
      @transaction_params = transaction_params
    end

    def run
      return error_response('Sua conta está inativa') unless transaction_params[:current_user].bank_account.active

      transaction_type = transaction_params[:transaction_type]
      transaction_type = Transaction.transaction_types.key(transaction_type.to_i).to_sym
      transaction_params[:transaction_type] = transaction_type

      OPERATIONS[transaction_type].new.run(transaction_params)
    end

    attr_reader :transaction_params
  end
end
