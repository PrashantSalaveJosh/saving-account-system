require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'when creating account ' do
    let(:account) { build :account }

    it 'should be valid account with valid parameters' do
      expect(account.valid?).to eq(true)
    end

    it 'should not be valid without account type' do
      account.account_type = nil
      expect(account.valid?).to eq(false)
    end

    it 'should not be valid without total balance' do
      account.total_balance = nil
      expect(account.valid?).to eq(false)
    end

    it 'should not be valid with invalid total balance' do
      account.total_balance = -100
      expect(account.valid?).to eq(false)
    end
    
  end
end
