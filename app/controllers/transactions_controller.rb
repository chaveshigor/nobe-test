class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @transaction = Transaction.new
  end

  def create
    create_transaction_params = transaction_params
    create_transaction_params[:current_user] = current_user
    new_transaction = TransactionServices::CreateTransactionService.new(create_transaction_params).run

    return redirect_to show_account_path if new_transaction && new_transaction&.save

    flash.alert = 'Você não possui saldo suficiente para efetuar a transação'
    redirect_to action: :new
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_receiver_number, :transaction_type, :amount)
  end
end
