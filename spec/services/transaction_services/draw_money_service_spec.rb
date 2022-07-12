require 'rails_helper'

RSpec.describe TransactionServices::DrawMoneyService do
  let!(:bank_account) { create(:bank_account, :with_user, balance: 50) }

  describe '#run' do
    context 'when account have money enough' do
      let!(:transaction_params) {{
        transaction_type: 'DRAW',
        amount: 10,
        current_user: bank_account.user
      }}

      it 'return the new transaction' do
        current_balance = bank_account.balance
        amount = transaction_params[:amount]
        fee = TransactionServices::TransactionBaseService.new.calculate_fee(amount)
        described_class.new.run(transaction_params)

        expect(bank_account.reload.balance).to eq(current_balance - (amount + fee))
      end
    end

    context 'when account dont have money enough' do
      let!(:transaction_params) {{
        transaction_type: 'DRAW',
        amount: 1000,
        current_user: bank_account.user
      }}

      it 'return false' do
        result = described_class.new.run(transaction_params)

        expect(result[:success]).to eq(false)
        expect(result[:message]).to eq('Saldo insuficiente')
      end
    end
  end
end
