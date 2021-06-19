FactoryBot.define do
  factory :user do
    id { rand(100..200) }
    name { Faker::Name.middle_name }
    email { Faker::Internet.email }
    mine_open { Faker::Boolean.boolean(true_ratio: 1) } #確率「0.5」に変更で50%テストに通る
    others_open { Faker::Boolean.boolean(true_ratio: 1) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end