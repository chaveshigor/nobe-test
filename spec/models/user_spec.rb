require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Assossiations' do
    it { should have_one(:bank_account) }
  end

  describe 'Validations' do
    subject {
      User.new(
        first_name: 'Son',
        last_name: 'Goku',
        phone: '21789654123',
        password: 'kamehameha',
        email: 'goku@test.com'
      )
    }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
  end
end
