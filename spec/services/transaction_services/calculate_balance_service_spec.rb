require 'rails_helper'

RSpec.describe TransactionServices::CalculateBalanceService do
  let(:current_transaction) { create(:transaction, :with_sender, :with_receiver, transaction_type: 'DRAW') }

  describe '#run' do
    context 'when account have money enough' do
      it 'return the new balance and fee' do
        current_balance = 1_000_000
        expect(described_class.new(current_transaction, current_balance).run).not_to be(false)
      end
    end

    context 'when account dont have money enough' do
      it 'return false' do
        current_balance = 1
        expect(described_class.new(current_transaction, current_balance).run).to eq(false)
      end
    end
  end
end
