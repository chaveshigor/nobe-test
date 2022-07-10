class Transaction < ApplicationRecord
  belongs_to :account_sender, class_name: 'BankAccount', foreign_key: 'account_sender_id'
  belongs_to :account_receiver, class_name: 'BankAccount', foreign_key: 'account_receiver_id'
end
