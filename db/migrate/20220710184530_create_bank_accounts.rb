class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.string :account_number
      t.numeric :balance, null: false, default: 0

      t.timestamps
    end
  end
end
