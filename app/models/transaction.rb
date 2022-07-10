class Transaction < ApplicationRecord
  belongs_to :account_sender
  belongs_to :account_receiver
end
