class Transaction < ApplicationRecord
  belongs_to :account_sender, class_name: 'BankAccount', foreign_key: 'account_sender_id'
  belongs_to :account_receiver, class_name: 'BankAccount', foreign_key: 'account_receiver_id'

  ALL_TRANSACTION_TYPES = {
    DRAW: { value: 0, operation: -1 },
    DEPOSIT: { value: 1, operation: +1 },
    SEND: { value: 2, operation: -1 }
  }.freeze

  enum transaction_type: ALL_TRANSACTION_TYPES.keys

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :transaction_type, presence: true

  def self.all_transaction_types
    ALL_TRANSACTION_TYPES
  end
end
