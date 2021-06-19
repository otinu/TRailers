require 'rails_helper'

describe 'ユーザー情報のテスト' do
  let!(:user) { FactoryBot.build(:user) }

  context "ログインのテスト" do
     it 'サインイン画面からログイン' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
    it 'サインアップ画面からログイン' do
      visit new_user_registration_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      check 'user[mine_open]'
      expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
    end
  end
  context "ユーザー情報変更のテスト" do
    before do
      visit new_user_registration_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      check 'user[mine_open]'

    end
    it "ユーザー情報を更新する" do
      visit edit_user_path(user)
      fill_in 'my_name', with: user.name
      fill_in 'user[introduction]', with: user.introduction
      click_button '更新する'
      expect(page).to have_link user.name
    end
  end
end