FactoryBot.define do
  factory :service do
    customer
    content { Faker::Lorem.characters(number:200) }
    place { Faker::Lorem.characters(number:10) }
    catchphrase { Faker::Lorem.characters(number:20) }
    image_id {nil}
    point { Faker::Number.number(digits: 10) }
    is_active { true }
    format { "online" }
  end
end