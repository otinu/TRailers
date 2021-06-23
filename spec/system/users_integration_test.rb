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
      user.id = 99999 # FactoryBotではUserID:1で生成するため、新規IDへ置き換え
      expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
    end
    it "ロゴのリンク(ログアウト)のテスト" do
      visit posts_path
      expect(page).to have_link "Logo", href: destroy_user_session_path
    end
  end
end

describe "ユーザー詳細のテスト" do
  let!(:user) { FactoryBot.build(:user) }
  let!(:post) { FactoryBot.build(:post) }

  before do
    sign_up_as(user)  # SignupSupportモジュールから呼び出し
    visit user_path(user)
  end

  context "ユーザー詳細のテスト" do
    it "マイアイコンのテスト" do
      link = find(".my-icon")
      expect(link[:href]).to eq user_path(user)
    end
    it "マイプロフィール編集のテスト" do
      link = find(".profile-edit")
      expect(link[:href]).to eq edit_user_path(user)
    end
    it "新規投稿のテスト" do
      link = find(".new-post")
      expect(link[:href]).to eq new_post_path
    end

    it "mine_openのテスト(公開時)" do
      link = find(".mine-open")
      expect(link[:href]).to eq count_view_mine_users_path(user, user: { mine_open: false })
    end
    it "mine_openのテスト(非公開時)" do
      find(".mine-open").click
      visit current_path
      link = find(".mine-open")
      expect(link[:href]).to eq count_view_mine_users_path(user, user: { mine_open: true })
    end
    it "others_openのテスト(公開時)" do
      link = find(".others-open")
      expect(link[:href]).to eq count_view_others_users_path(user, user: { others_open: false })
    end
    it "others_openのテスト(非公開時)" do
      find(".others-open").click
      visit current_path
      link = find(".others-open")
      expect(link[:href]).to eq count_view_others_users_path(user, user: { others_open: true })
    end
  end

  context "投稿後のユーザー詳細のテスト" do
    before "投稿してからユーザー詳細へ移動" do
      new_post(post)  # NewPostSupportモジュールから呼び出し
      visit user_path(user)
    end

    it "投稿後のリンクの確認" do
      expect(page).to have_link post.title, href: post_path(1)
      link = find(".post-edit")
      expect(link[:href]).to eq edit_post_path(1)
      link = find(".post-destroy")
      expect(link[:href]).to eq post_path(1)
    end
  end
end

describe "ユーザー情報編集のテスト" do
  let!(:user) { FactoryBot.build(:user) }

  before do
    sign_up_as(user)  # SignupSupportモジュールから呼び出し
    visit edit_user_path(user)
  end

  context "ユーザー情報変更のテスト" do
    it "ユーザー情報を更新する" do
      expect(page).to have_content '自己紹介'
      fill_in 'user[name]', with: "蒸気機関車"
      fill_in 'user[introduction]', with: "SL"
      click_button "更新する"
      expect(page).to have_link "蒸気機関車"
    end
  end
end
