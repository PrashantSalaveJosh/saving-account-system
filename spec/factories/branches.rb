FactoryBot.define do
  factory :branch do
    name { Faker::Name.name }
    contact_no { Faker::Number.number(digits: 10) }
    address { Faker::Address.full_address }
    ifsc { Faker::Alphanumeric.alphanumeric(number: 10, min_numeric: 4) }
    
  end
end
