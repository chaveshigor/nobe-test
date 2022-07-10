class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :account_sender, null: false, foreign_key: { to_table: 'bank_accounts' }
      t.references :account_receiver, null: false, foreign_key: { to_table: 'bank_accounts' }
      t.numeric :amount, null: false
      t.numeric :fee, null: true
      t.string :transaction_type, null: false
      t.timestamps
    end
  end
end
