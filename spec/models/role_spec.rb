require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'when creating role' do
    let (:role) { build :role }

    it 'should be valid role with valid parameters' do
      expect(role.valid?).to eq(true)
    end

    it 'should not be valid without name' do
      role.name = nil
      expect(role.valid?).to eq(false)
    end

    it 'should not be valid without key' do
      role.key = nil
      expect(role.valid?).to eq(false)
    end

  end
end