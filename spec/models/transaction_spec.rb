require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'when creating transaction ' do
    let(:transaction) { build :transaction }

    it 'should be valid transaction with valid parameters' do
      expect(transaction.valid?).to eq(true)
    end

    it 'should not be valid without transaction type' do
      transaction.transaction_type = nil
      expect(transaction.valid?).to eq(false)
    end

    it 'should not be valid without transaction details' do
      transaction.details = nil
      expect(transaction.valid?).to eq(false)
    end

    it 'should not be valid without amount' do
      transaction.amount = nil
      expect(transaction.valid?).to eq(false)
    end

    it 'should not be valid without balance' do
      transaction.balance = nil
      expect(transaction.valid?).to eq(false)
    end

    it 'should not be valid with invalid amount' do
      transaction.amount = -100
      expect(transaction.valid?).to eq(false)
    end

    it 'should not be valid with invalid balance' do
      transaction.amount = -100
      expect(transaction.valid?).to eq(false)
    end

  end
end
