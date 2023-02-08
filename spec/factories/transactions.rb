FactoryBot.define do
  factory :transaction do
    transaction_type { 'credit' }
    details { 'Netbanking' }
    amount { Faker::Number.number( digits: 4 ) }
    balance { Faker::Number.number( digits: 4 ) }
    association :account
    
  end
end
