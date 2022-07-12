require 'rails_helper'

RSpec.describe TransactionServices::SendMoneyService do
  let!(:bank_account_sender) { create(:bank_account, :with_user, balance: 50) }
  let!(:bank_account_receiver) { create(:bank_account, :with_user, balance: 0) }

  describe '#run' do
    context 'when account have money enough' do
      let!(:transaction_params) {{
        transaction_type: 'SEND',
        amount: 10,
        current_user: bank_account_sender.user,
        account_receiver_number: bank_account_receiver.account_number
      }}

      it 'return the new transaction' do
        current_balance = bank_account_sender.balance
        amount = transaction_params[:amount]
        fee = TransactionServices::TransactionBaseService.new.calculate_fee(amount)
        described_class.new.run(transaction_params)

        expect(bank_account_sender.reload.balance).to eq(current_balance - (amount + fee))
        expect(bank_account_receiver.reload.balance).to eq(amount)
      end
    end

    context 'when account dont have money enough' do
      let!(:transaction_params) {{
        transaction_type: 'SEND',
        amount: 1000,
        current_user: bank_account_sender.user,
        account_receiver_number: bank_account_receiver.account_number
      }}

      it 'return false' do
        result = described_class.new.run(transaction_params)

        expect(result[:success]).to eq(false)
        expect(result[:message]).to eq('Saldo insuficiente')
      end
    end

    context 'when receiver account does not exist' do
      let!(:transaction_params) {{
        transaction_type: 'SEND',
        amount: 1,
        current_user: bank_account_sender.user,
        account_receiver_number: '123'
      }}

      it 'return error' do
        result = described_class.new.run(transaction_params)

        expect(result[:success]).to eq(false)
        expect(result[:message]).to eq("Conta #{transaction_params[:account_receiver_number]} não encontrada")
      end
    end
  end
end
