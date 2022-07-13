require 'rails_helper'

RSpec.describe 'Create Transactions', type: :system do
  include Devise::Test::IntegrationHelpers

  describe 'When user try to create a transaction' do
    let!(:user_sender) { create(:user, :with_bank_account) }
    let!(:user_receiver) { create(:user, :with_bank_account) }

    before do
      sign_in user_sender
    end

    context 'when receiver account is not actived' do
      it 'shows an error' do
        user_receiver.bank_account.update(active: false)
        visit new_transaction_path

        find('#transaction_transaction_type').send_keys('SEND')
        find('#transaction_amount').send_keys('10')
        find('#transaction_account_receiver_number').send_keys(user_receiver.bank_account.account_number)
        click_button 'Create Transaction'

        expect(page).to have_content('Conta de destino está inativa')
      end
    end

    context 'when current user bank account is not actived' do
      it 'shows an error' do
        user_sender.bank_account.update(active: false)
        visit new_transaction_path

        find('#transaction_transaction_type').send_keys('SEND')
        find('#transaction_amount').send_keys('10')
        find('#transaction_account_receiver_number').send_keys(user_receiver.bank_account.account_number)
        click_button 'Create Transaction'

        expect(page).to have_content('Sua conta está inativa')
      end
    end

    context 'when user try to send money' do
      context 'when user dont have enougth money' do
        it 'shows an error' do
          visit new_transaction_path

          find('#transaction_transaction_type').send_keys('SEND')
          find('#transaction_amount').send_keys('10000')
          find('#transaction_account_receiver_number').send_keys(user_receiver.bank_account.account_number)
          click_button 'Create Transaction'

          expect(page).to have_content('Saldo insuficiente')
        end
      end

      context 'when user have enougth money' do
        it 'shows an error' do
          user_sender.bank_account.update(balance: 10_000)
          visit new_transaction_path

          find('#transaction_transaction_type').send_keys('SEND')
          find('#transaction_amount').send_keys('10')
          find('#transaction_account_receiver_number').send_keys(user_receiver.bank_account.account_number)
          click_button 'Create Transaction'

          expect(page).not_to have_content('Saldo insuficiente')
        end
      end
    end
  end
end
