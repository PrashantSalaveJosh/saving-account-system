FactoryBot.define do
  factory :role do
    name { Faker::Name.name }
    key { Faker::Name.name }
    
  end
end
