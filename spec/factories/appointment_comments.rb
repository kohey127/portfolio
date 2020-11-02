FactoryBot.define do
  factory :appointment_comment do
    customer
    appointment
    content { Faker::Lorem.characters(number:200) }
  end
end
