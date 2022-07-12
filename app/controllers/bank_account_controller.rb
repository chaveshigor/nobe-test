class BankAccountController < ApplicationController
  before_action :authenticate_user!

  def show_account
    user_id = current_user.id

    @bank_account = User.find(user_id).bank_account
  end
end
