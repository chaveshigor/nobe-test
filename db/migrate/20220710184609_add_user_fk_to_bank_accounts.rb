class AddUserFkToBankAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :bank_accounts, :user, index: true
    add_foreign_key :bank_accounts, :users
  end
end
