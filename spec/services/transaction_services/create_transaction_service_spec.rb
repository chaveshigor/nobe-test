require 'rails_helper'

RSpec.describe TransactionServices::CreateTransactionService do
  let!(:bank_account_sender) { create(:bank_account, :with_user, balance: 50) }
  let!(:bank_account_receiver) { create(:bank_account, :with_user, balance: 0) }

  let(:runner) { instance_double('Runner') }

  before do
    allow(runner).to receive(:run).and_return(true)
  end

  def build_params(transaction_type)
    {
      transaction_type: transaction_type,
      amount: 10,
      current_user: bank_account_sender.user,
      account_receiver_number: bank_account_receiver.account_number
    }
  end

  describe '#run' do
    context 'when params are valid' do
      [
        { action: 'DRAW', value: '0', object: TransactionServices::DrawMoneyService },
        { action: 'DEPOSIT', value: '1', object: TransactionServices::DepositMoneyService },
        { action: 'SEND', value: '2', object: TransactionServices::SendMoneyService }
      ].each do |event|
        it "call the #{event[:action]} object" do
          allow(event[:object]).to receive(:new).and_return(runner)
          payload = build_params(event[:value])

          expect(runner).to receive(:run).with(payload)
          described_class.new(payload).run
        end
      end
    end

    context 'when my account is not actived' do
      it 'return error' do
        bank_account_sender.active = false
        payload = build_params('SEND')
        result = described_class.new(payload).run

        expect(result[:success]).to eq(false)
        expect(result[:message]).to eq('Sua conta está inativa')
      end
    end
  end
end
