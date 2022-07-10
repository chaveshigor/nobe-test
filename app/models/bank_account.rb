class BankAccount < ApplicationRecord
  before_validation :generate_bank_account_number, on: :save

  belongs_to :user

  has_many :sended, class_name: 'Transaction', foreign_key: 'account_sender_id'
  has_many :received, class_name: 'Transaction', foreign_key: 'account_receiver_id'

  validates :account_number, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  private

  def generate_bank_account_number
    number_of_digits = 5

    self.account_number = SecureRandom.random_number(10**number_of_digits)
  end
end
