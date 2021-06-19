FactoryBot.define do
  factory :post do
    user_id { rand(10) }
    title { Faker::Book.title }
    tag_list { "Rails" }
    explanation { Faker::Lorem.characters(number:30) }
  end
end