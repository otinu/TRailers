FactoryBot.define do
  factory :user do
    trait :first do
      id { 1 }
      name { Faker::Lorem.characters(number: 10) }
      email { Faker::Internet.email }
      mine_open { Faker::Boolean.boolean(true_ratio: 1) }
      others_open { Faker::Boolean.boolean(true_ratio: 1) }
      password { 'password' }
      password_confirmation { 'password' }
    end
    trait :second do
      id { 2 }
      name { Faker::Lorem.characters(number: 10)  }
      email { Faker::Internet.email }
      mine_open { Faker::Boolean.boolean(true_ratio: 1) }
      others_open { Faker::Boolean.boolean(true_ratio: 1) }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end
end
