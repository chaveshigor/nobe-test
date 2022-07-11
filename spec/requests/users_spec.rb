require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user, email: 'old_user@test.com') }

  def create_user_request(email)
    post '/users', params: {
      user: {
        email: email,
        first_name: 'higor',
        last_name: 'chaves',
        phone: '21147852369',
        password: 'password'
      }
    }
  end

  describe 'POST /users/sign_up' do
    context 'when user dont have an account' do
      it 'create a new user' do
        expect { create_user_request('new_user@test.com') }.to change(User, :count).by(1)
                                                           .and change(BankAccount, :count).by(1)
      end
    end

    context 'when user already have an account' do
      it 'dont create a new user' do
        expect { create_user_request('old_user@test.com') }.not_to change(User, :count)
      end
    end
  end
end
