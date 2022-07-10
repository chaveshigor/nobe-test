class AddBankAccountFkToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :bank_account, index: true
  end
end
