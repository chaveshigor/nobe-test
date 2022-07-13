class AddActiveToBankAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_accounts, :active, :boolean, default: true
  end
end
