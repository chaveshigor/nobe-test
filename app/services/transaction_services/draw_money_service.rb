module TransactionServices
  class DrawMoneyService < TransactionBaseService
    def run(transaction_params)
      draw_money(transaction_params)
    end

    private

    def draw_money(transaction_params)
      amount = transaction_params[:amount].to_f
      transaction_type = transaction_params[:transaction_type]

      bank_account = transaction_params[:current_user].bank_account
      current_balance = bank_account.balance

      new_transaction = Transaction.new(
        transaction_type: transaction_type,
        account_receiver_id: bank_account.id,
        account_sender_id: bank_account.id,
        amount: amount
      )

      fee = calculate_fee(amount)
      new_balance = current_balance - (fee + amount)
      return error_response('Saldo insuficiente') if new_balance.negative?

      new_transaction.fee = fee
      bank_account.update(balance: new_balance)

      success_response(new_transaction)
    end
  end
end
