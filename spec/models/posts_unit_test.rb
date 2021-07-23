require 'rails_helper'

describe 'Postモデルのテスト', type: :model do
  before do
    @post = FactoryBot.build(:post)
    @post.user = FactoryBot.build(:user)
    @post.post_file = fixture_file_upload("/lens.jpeg")
  end

  it "有効な新規投稿の場合は保存されるか" do
    expect(@post.user).to be_valid
    expect(@post.post_file).to be_valid
    expect(@post).to be_valid
  end

  it "タイトルが21文字以上の投稿は保存されないか" do
    @post.title = Faker::Lorem.characters(number: 21)
    @post.valid?
    expect(@post.errors.full_messages).to eq ["投稿名は2～20文字以内で入力してください"]
  end

  it "タイトルが1文字の投稿は保存されないか" do
    @post.title = Faker::Lorem.characters(number: 1)
    @post.valid?
    expect(@post.errors.full_messages).to eq ["投稿名は2～20文字以内で入力してください"]
  end

  it "投稿へのコメントが501文字以上の投稿は保存されないか" do
    @post.explanation = Faker::Lorem.characters(number: 501)
    @post.valid?
    expect(@post.errors.full_messages).to eq ["投稿へのコメントは500文字以内でお願いします"]
  end

  it "動画投稿は保存されるか" do
    @post.post_file = fixture_file_upload("/test.mp4")
    expect(@post).to be_valid
  end

  it "PDF投稿は保存されるか" do
    @post.post_file = fixture_file_upload("/test.pdf")
    expect(@post).to be_valid
  end

  it "容量オーバーの投稿は保存されないか" do
    @post.post_file = fixture_file_upload("/post_over_test.mp4")
    @post.valid?
    expect(@post.errors.full_messages).to eq ["投稿ファイルは3MBまででお願いします"]
  end

  it "JPEG,GIF,PNG,PDF,MP4以外の投稿は保存されないか" do
    @post.post_file = fixture_file_upload("/test.css")
    @post.valid?
    expect(@post.errors.full_messages).to eq ["投稿ファイルのファイル形式では送信できません 他のファイル形式で送信をお願いします"]
  end
end
