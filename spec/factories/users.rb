FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    # first_name { Faker::Name.name }
    # last_name { Faker::Name.name }
    # contact_no { Faker::Number.number(digits: 10) }
    # address { Faker::Address.full_address }
    # dob { Faker::Date.in_date_period }
    # gender { Faker::Gender.binary_type }
    association :role
    
  end
end
