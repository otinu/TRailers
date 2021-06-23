FactoryBot.define do
  factory :post do
    user_id { 1 }
    title { Faker::Lorem.characters(number: 10) }
    tag_list { "Rails" }
    explanation { Faker::Lorem.characters(number: 30) }
  end
end
