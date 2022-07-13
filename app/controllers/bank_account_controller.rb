class BankAccountController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user!

  def show_account
    user_id = current_user.id
    @bank_account = User.find(user_id).bank_account
    if params[:'/show_account'] && (params[:'/show_account'][:initial_date] || params[:'/show_account'][:final_date])
      @transactions = filter_by_date
    else
      @transactions = nil
    end
  end

  private

  def filter_by_date
    initial_date = params[:'/show_account'][:initial_date].blank? ? @bank_account.created_at : params[:'/show_account'][:initial_date]
    final_date = params[:'/show_account'][:final_date].blank? ? Time.zone.now : params[:'/show_account'][:final_date]

    @bank_account.transactions.where('created_at >= ? AND created_at <= ?', initial_date, final_date)
  end

  def transaction_params
    params.permit(:initial_date, :final_date)
  end
end
