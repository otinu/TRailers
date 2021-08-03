require 'rails_helper'

describe 'Goodsボタンのテスト' do
let!(:user) { FactoryBot.build(:user, :first) }
let!(:post) { FactoryBot.build(:post) }

  before "英語に切り替え" do
    visit new_user_session_path
    find('.fa-language').click
  end

  context "日本語表記の確認" do
    it "サインイン画面" do
      visit new_user_session_path
      expect(page).to have_selector 'div.form-group', text: 'Email'
      expect(page).to have_selector 'div.form-group', text: 'Password'
      expect(page).to have_selector 'div.form-group', text: 'Remember me'
      find_button 'Log in'
      expect(page).to have_selector 'div a', text: 'Sign up'
      expect(page).to have_selector 'div a', text: 'Forgot password?'
    end
    it "サインアップ画面" do
      visit new_user_registration_path
      expect(page).to have_selector 'div label', text: 'Name'
      expect(page).to have_selector 'div label', text: 'Email'
      expect(page).to have_selector 'div label', text: 'Password'
      expect(page).to have_selector 'div label', text: 'Password confirmation'
      expect(page).to have_selector 'div a', text: 'TOS'
      find_button 'Sign up'
      expect(page).to have_selector 'div', text: 'Log in'
    end
     it "ユーザー詳細画面" do
      sign_up_as_english(user) # SignupSupportモジュールから呼び出し
      visit user_path(user)
      expect(page).to have_selector 'th', text: 'Title'
      expect(page).to have_selector 'th', text: 'Edit'
      expect(page).to have_selector 'th', text: 'Delete'
    end
    it "ユーザー情報編集画面" do
      sign_up_as_english(user)
      visit edit_user_path(user)
      expect(page).to have_selector 'div label', text: 'Name'
      expect(page).to have_selector 'div label', text: 'Image'
      expect(page).to have_selector 'div label', text: 'Introduction'
      find_button 'Update User'
    end
    it "新規投稿画面" do
      sign_up_as_english(user)
      visit new_post_path
      expect(page).to have_selector 'div label', text: 'Title'
      expect(page).to have_selector 'div label', text: 'Image'
      expect(page).to have_selector 'div label', text: 'Genre'
      expect(page).to have_selector 'div label', text: 'Comment'
      find_button 'Create Post'
    end
    it "投稿編集画面" do
      sign_up_as_english(user)
      new_english_post(post)  # PostSupportモジュールから呼び出し
      find('.post-glass').click
      find('.fa-file-pen').click
      expect(page).to have_selector 'div label', text: 'Title'
      expect(page).to have_selector 'div label', text: 'Image'
      expect(page).to have_selector 'div label', text: 'Comment'
      find_button 'Update Post'
    end

  end
end