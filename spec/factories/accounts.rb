FactoryBot.define do
  factory :account do
    account_no { Faker::Bank.account_number(digits: 9) }
    account_type { 'saving' }
    total_balance { Faker::Number.number(digits: 4) }
    association :user
    association :branch
    
  end
end
