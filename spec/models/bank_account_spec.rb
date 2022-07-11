require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  let!(:bank_account) { create(:bank_account, :with_user) }

  describe 'Assossiations' do
    it { should belong_to(:user) }
    it { should have_many(:sended) }
    it { should have_many(:received) }
  end

  describe 'Validations' do
    subject { bank_account }

    it { should validate_uniqueness_of(:account_number) }
    it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end
end
