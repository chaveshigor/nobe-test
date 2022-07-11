class Transaction < ApplicationRecord
  belongs_to :account_sender, class_name: 'BankAccount', foreign_key: 'account_sender_id'
  belongs_to :account_receiver, class_name: 'BankAccount', foreign_key: 'account_receiver_id'

  enum transaction_type: { DRAW: 0, DEPOSIT: 1, SEND: 2 }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :transaction_type, presence: true
end
