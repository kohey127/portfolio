FactoryBot.define do
  factory :exp_history do
    customer 
    balance { Faker::Number.number(digits: 200) }
    trigger_id { Faker::Number.number(digits: 1) }
  end
end
