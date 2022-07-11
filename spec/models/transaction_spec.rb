require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Assossiations' do
    it { should belong_to(:account_sender) }
    it { should belong_to(:account_receiver) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }

    it { should define_enum_for(:transaction_type).with_values(DRAW: 0, DEPOSIT: 1, SEND: 2) }
    it { should validate_presence_of(:transaction_type) }
  end
end
