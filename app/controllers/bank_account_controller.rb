class BankAccountController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user!

  def show_account
    user_id = current_user.id
    @bank_account = User.find(user_id).bank_account
    if params[:'/show_account'] && (params[:'/show_account'][:initial_date] || params[:'/show_account'][:final_date])
      @transactions = filter_by_date(params[:'/show_account'][:initial_date], params[:'/show_account'][:final_date])
    else
      @transactions = nil
    end

    @transactions_to_export = filter_by_date(params[:initial_date], params[:final_date]) if params[:initial_date] || params[:final_date]

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"transacoes_#{Time.zone.today}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def initial_date
    @initial_date || params[:'/show_account'][:initial_date]
  end

  private

  def filter_by_date(initial_date, final_date)
    initial_date = initial_date.blank? ? @bank_account.created_at : Time.zone.parse(initial_date)
    final_date = final_date.blank? ? Time.zone.now : Time.zone.parse(final_date) + 86_399

    @bank_account.transactions.where('created_at >= ? AND created_at <= ?', initial_date, final_date)
  end

  def transaction_params
    params.permit(:initial_date, :final_date)
  end
end
