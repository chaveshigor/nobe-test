require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  describe 'When user try to sign up' do
    let!(:user) { build(:user) }

    context 'when credentials are valid' do
      it 'shows the right content' do
        visit new_user_registration_path

        find('#user_first_name').send_keys(user.first_name)
        find('#user_last_name').send_keys(user.last_name)
        find('#user_phone').send_keys(user.phone)
        find('#user_email').send_keys(user.email)
        find('#user_password').send_keys(user.password)
        find('#user_password_confirmation').send_keys(user.password)
        find('#new_user > div.actions > input').click

        expect(page).to have_content("Bem-vindo(a) #{user.first_name.titleize}")
      end
    end

    context 'when email is blank' do
      it 'shows the right content' do
        visit new_user_registration_path

        find('#user_first_name').send_keys(user.first_name)
        find('#user_last_name').send_keys(user.last_name)
        find('#user_phone').send_keys(user.phone)
        find('#user_password').send_keys(user.password)
        find('#user_password_confirmation').send_keys(user.password)
        find('#new_user > div.actions > input').click

        expect(page).to have_content("Email can't be blank")
      end
    end
  end
end
