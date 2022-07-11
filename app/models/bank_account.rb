class BankAccount < ApplicationRecord
  before_create :generate_bank_account_number

  belongs_to :user
  has_many :sended, class_name: 'Transaction', foreign_key: 'account_sender_id'
  has_many :received, class_name: 'Transaction', foreign_key: 'account_receiver_id'

  validates :account_number, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def transactions
    Transaction.where(account_sender_id: id)
               .or(Transaction.where(account_receiver_id: id))
               .distinct
               .order(created_at: :desc)
  end

  private

  def generate_bank_account_number
    number_of_digits = 5

    self.account_number = SecureRandom.random_number(10**number_of_digits)
  end
end
