module TransactionServices
  class DepositMoneyService < TransactionBaseService
    def run(transaction_params)
      deposit_money(transaction_params)
    end

    private

    def deposit_money(transaction_params)
      amount = transaction_params[:amount].to_f
      transaction_type = transaction_params[:transaction_type]

      bank_account_sender = transaction_params[:current_user].bank_account
      bank_account_receiver = BankAccount.find_by(account_number: transaction_params[:account_receiver_number])
      return error_response("Conta #{transaction_params[:account_receiver_number]} não encontrada") if bank_account_receiver.nil?

      current_balance_receiver = bank_account_receiver.balance

      new_transaction = Transaction.new(
        transaction_type: transaction_type,
        account_sender_id: bank_account_sender.id,
        account_receiver_id: bank_account_receiver.id,
        amount: amount
      )

      fee = calculate_fee(amount)
      return error_response("Montante insuficiente. Taxa é de R$#{fee}") if (amount - fee).negative?

      new_balance_receiver = current_balance_receiver + amount - fee
      new_transaction.fee = fee

      bank_account_receiver.update(balance: new_balance_receiver)

      success_response(new_transaction)
    end
  end
end
