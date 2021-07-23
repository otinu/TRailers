require 'rails_helper'

describe 'Userモデルのテスト', type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
    it "有効なユーザー情報の場合は保存されるか" do
      expect(@user).to be_valid
    end
    
  context "入力のテスト" do
    it "名前が21文字以上のユーザー情報は保存されないか" do
      @user.name = Faker::Lorem.characters(number: 21)
      @user.valid?
      expect(@user.errors.full_messages).to eq ["名前は20文字以内で入力してください"]
    end

    it "名前が1文字のユーザー情報は保存されないか" do
      @user.name = Faker::Lorem.characters(number: 1)
      @user.valid?
      expect(@user.errors.full_messages).to eq ["名前は2文字以上で入力してください"]
    end

    it "自己紹介文が51文字以上のユーザー情報は保存されないか" do
      @user.introduction = Faker::Lorem.characters(number: 51)
      @user.valid?
      expect(@user.errors.full_messages).to eq ["自己紹介は50文字以内で入力してください"]
    end
  end

  context "プロフィール画像投稿のテスト" do
    it "有効なプロフィール画像の場合は保存されるか" do
      @user.profile_image = fixture_file_upload("/lens.jpeg")
      expect(@user.profile_image).to be_valid
      expect(@user).to be_valid
    end
    it "動画投稿は保存されないか" do
      @user.profile_image = fixture_file_upload("/test.mp4")
      @user.valid?
      expect(@user.errors.full_messages).to include("プロフィール画像はJPEG、GIF、PNG画像のいずれかでお選びください")
    end

    it "PDF投稿は保存されないか" do
      @user.profile_image = fixture_file_upload("/test.pdf")
      @user.valid?
      expect(@user.errors.full_messages).to include("プロフィール画像はJPEG、GIF、PNG画像のいずれかでお選びください")
    end
    
    it "JPEG,GIF,PNG以外の投稿は保存されないか" do
      @user.profile_image = fixture_file_upload("/test.css")
      @user.valid?
      expect(@user.errors.full_messages).to include("プロフィール画像はJPEG、GIF、PNG画像のいずれかでお選びください")
    end

    it "容量オーバーの投稿は保存されないか" do
      @user.profile_image = fixture_file_upload("/profile_over_test.png")
      @user.valid?
      expect(@user.errors.full_messages).to include("プロフィール画像は100KBまででお願いします")
    end
  end
end
