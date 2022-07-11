class BankAccountController < ApplicationController
  before_action :authenticate_user!

  def show
    user_id = params[:id]

    @bank_account = User.find(user_id).bank_account
  end
end
