require 'rails_helper'

describe 'ユーザーモデルのテスト' do
  it "有効な登録情報の場合は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end