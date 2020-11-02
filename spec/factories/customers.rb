FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    introduction { Faker::Lorem.characters(number:20) }
    image_id {""}
    based { Faker::Lorem.characters(number:10) }
    point { Faker::Number.number(digits: 3) }
    exp_point { Faker::Number.number(digits: 3) }
    is_active { true }
    password { 'password' }
    password_confirmation { 'password' }
  end
end