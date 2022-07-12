require 'faker'

FactoryBot.define do
  factory :bank_account do
    balance { 0 }

    trait :with_user do
      after(:build) do |bank_account|
        bank_account.user = build(:user)
      end
    end
  end
end
