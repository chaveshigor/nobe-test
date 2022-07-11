require 'faker'

FactoryBot.define do
  factory :transaction do
    amount { 50 }

    trait :with_sender do
      after(:build) do |transaction|
        transaction.account_sender = create(:bank_account, :with_user)
      end
    end

    trait :with_receiver do
      after(:build) do |transaction|
        transaction.account_receiver = create(:bank_account, :with_user)
      end
    end
  end
end
