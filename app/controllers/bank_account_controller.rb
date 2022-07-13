class BankAccountController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user!

  def show_account
    user_id = current_user.id
    p '-------------koé', transaction_params
    @bank_account = User.find(user_id).bank_account
    p params[:'/show_account'][:initial_date]
    if params[:'/show_account'][:initial_date] || params[:'/show_account'][:final_date]
      @transactions = filter_by_date
    else
      @transactions = nil
    end
  end

  private

  def filter_by_date
    initial_date = params[:'/show_account'][:initial_date] || @bank_account.created_at
    final_date = params[:'/show_account'][:final_date] || Time.zone.today

    @bank_account.transactions.where('created_at >= ? AND created_at <= ?', initial_date, final_date)
  end

  def transaction_params
    params.permit(:initial_date, :final_date)
  end
end
