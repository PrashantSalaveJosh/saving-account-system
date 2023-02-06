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
      debugger
      expect(account.valid?).to eq(false)
    end

    # it 'should not save user with email field missing' do
    #   user.email = nil
    #   expect(user.valid?).to eq(false)
    # end

    # it 'should not valid without password' do
    #   user.password = nil
    #   expect(user.valid?).to eq(false)
    # end
  end
end
