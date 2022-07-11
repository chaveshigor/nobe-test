class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    current_balance = BankAccount.find_by(id: account_sender_id).balance
    account_receiver = BankAccount.find_by(account_number: transaction_params[:account_receiver_number])

    transaction = Transaction.new
    transaction.account_sender_id = @current_user.bank_account.id
    transaction.account_receiver_id = account_receiver.id
    transaction.transaction_type = transaction_params[:transaction_type]
    transaction.amount = transaction_params[:amount]

    result = Services::TransactionServices::CalculateBalance.new(transaction, current_balance).run
    # retornar erro se result = false
    transaction.fee = result[1]
    transaction.save
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_receiver_number, :transaction_type, :amount)
  end
end
