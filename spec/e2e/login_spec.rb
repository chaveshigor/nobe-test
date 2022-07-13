require 'rails_helper'

RSpec.describe 'Hello world', type: :system do
  describe 'index page' do
    let!(:user) { create(:user, :with_bank_account) }

    context 'when credentials are valid' do
      it 'shows the right content' do
        visit new_user_session_path

        find('#user_email').send_keys(user.email)
        find('#user_password').send_keys(user.password)
        find('#new_user > div.text-center.text-lg-start.mt-4.pt-2 > input').click

        expect(page).to have_content("Bem-vindo(a) #{user.first_name.titleize}")
      end
    end

    context 'when credentials are not valid' do
      it 'shows the right content' do
        visit new_user_session_path

        find('#user_email').send_keys(user.email)
        find('#user_password').send_keys('wrong password here')
        find('#new_user > div.text-center.text-lg-start.mt-4.pt-2 > input').click

        expect(page).to have_content('Invalid Email or password.')
      end
    end
  end
end
