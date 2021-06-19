require 'rails_helper'

describe '【Max Red7】 Userモデルのテスト', type: :model do
  before do
      @user = FactoryBot.build(:user)
  end
  context "プロフィール画像投稿前のテスト" do
    it "有効なユーザー情報の場合は保存されるか" do
        expect(@user).to be_valid
      end

    it "【Red1】名前がが21文字以上のユーザー情報は保存されないか" do
        @user.name = Faker::Lorem.characters(number:21)
        expect(@user).to be_valid
      end

    it "【Red2】タイトルが1文字のユーザー情報は保存されないか" do
        @user.title = Faker::Lorem.characters(number:1)
        expect(@user).to be_valid
      end

    it "【Red3】自己紹介文が51文字以上のユーザー情報は保存されないか" do
        @user.explanation = Faker::Lorem.characters(number:51)
        expect(@user).to be_valid
      end
  end
  context "プロフィール画像投稿のテスト" do
    it "有効なプロフィール画像の場合は保存されるか" do
        @user.profile_image = fixture_file_upload("/lens.jpeg")
        expect(@user.profile_image).to be_valid
        expect(@user).to be_valid
      end
    it "【Red4】動画投稿は保存されないか" do
        @user.profile_image = fixture_file_upload("/test.mp4")
        expect(@user).to be_valid
    end

    it "【Red5】PDF投稿は保存されないか" do
        @user.profile_image = fixture_file_upload("/test.pdf")
        expect(@user).to be_valid
    end

    it "【Red6】容量オーバーの投稿は保存されないか" do
        @post.post_file = fixture_file_upload("/profile_over_test.mp4")
        expect(@post).to be_valid
      end

    it "【Red7】JPEG,GIF,PNG以外の投稿は保存されないか" do
        @user.post_file = fixture_file_upload("/test.css")
        expect(@user).to be_valid
      end
  end
end