require 'rails_helper'

describe '新規登録' do
    it 'サインアップをする' do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Name.middle_name
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"
      check 'user[mine_open]'
      expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
    end
  end
