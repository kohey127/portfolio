FactoryBot.define do
  factory :appointment do
    service
    to_customer_id { 2 }
    from_customer_id { 1 }
    request_format { 'message' }
    request_date { 'undecided'}
    status {'applying'}
  end
end
