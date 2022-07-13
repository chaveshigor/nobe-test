require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}_#{last_name}@test.com" }
    password { '12345678' }
    phone { '21789654123' }

    trait :with_bank_account do
      after(:build) do |user|
        user.bank_account = build(:bank_account)
      end
    end
  end
end
