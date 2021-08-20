require 'rails_helper'

describe 'Goodsボタンのテスト' do
  let!(:user) { FactoryBot.build(:user, :first) }
  let!(:post) { FactoryBot.build(:post) }

  context "日本語表記の確認" do
    it "サインイン画面" do
      visit new_user_session_path
      sleep 2
      expect(page).to have_selector 'div.form-group', text: 'メールアドレス'
      expect(page).to have_selector 'div.form-group', text: 'パスワード'
      expect(page).to have_selector 'div.form-group', text: '次回から自動的にログイン'
      expect(page).to have_selector 'div.form-group', text: 'ログイン'
      expect(page).to have_selector 'div a', text: '新規登録'
      expect(page).to have_selector 'div a', text: 'パスワード再発行'
    end
    it "サインアップ画面" do
      visit new_user_registration_path
      sleep 2
      expect(page).to have_selector 'div label', text: '名前'
      expect(page).to have_selector 'div label', text: 'メールアドレス'
      expect(page).to have_selector 'div label', text: 'パスワード'
      expect(page).to have_selector 'div label', text: '確認用パスワード'
      expect(page).to have_selector 'div a', text: '利用規約'
      find_button '新規登録'
      expect(page).to have_selector 'div', text: 'ログイン'
    end
    it "ユーザー詳細画面" do
      sign_up_as(user) # SignupSupportモジュールから呼び出し
      visit user_path(user)
      expect(page).to have_selector 'th', text: '投稿名'
      expect(page).to have_selector 'th', text: '投稿を編集する'
      expect(page).to have_selector 'th', text: '投稿を削除する'
    end
    it "ユーザー情報編集画面" do
      sign_up_as(user)
      visit edit_user_path(user)
      expect(page).to have_selector 'div label', text: '名前'
      expect(page).to have_selector 'div label', text: 'プロフィール画像'
      expect(page).to have_selector 'div label', text: '自己紹介'
      find_button '更新する'
    end
    it "新規投稿画面" do
      sign_up_as(user)
      visit new_post_path
      expect(page).to have_selector 'div label', text: '投稿名'
      expect(page).to have_selector 'div label', text: '投稿ファイル'
      expect(page).to have_selector 'div label', text: 'ジャンル'
      expect(page).to have_selector 'div label', text: '投稿へのコメント'
      find_button '登録する'
    end
    it "投稿編集画面" do
      sign_up_as(user)
      new_post(post)
      sleep 1
      find('.post-glass').click
      sleep 1
      find('.fa-file-pen').click
      expect(page).to have_selector 'div label', text: '投稿名'
      expect(page).to have_selector 'div label', text: '投稿ファイル'
      expect(page).to have_selector 'div label', text: '投稿へのコメント'
      find_button '更新する'
    end
  end
end
