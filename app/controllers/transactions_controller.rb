class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @transaction = Transaction.new
  end

  def create
    create_transaction_params = transaction_params
    create_transaction_params[:current_user] = current_user
    result = TransactionServices::CreateTransactionService.new(create_transaction_params).run

    return redirect_to show_account_path if result[:success] && result[:transaction]&.save

    flash.alert = result[:message]
    redirect_to action: :new
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_receiver_number, :transaction_type, :amount)
  end
end
