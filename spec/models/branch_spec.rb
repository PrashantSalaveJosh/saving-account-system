require 'rails_helper'

RSpec.describe Branch, type: :model do
  context 'when creating branch' do
    let (:branch) { build :branch }

    it 'should be valid branch with valid parameters' do
      expect(branch.valid?).to eq(true)
    end

    it 'should not be valid without name' do
      branch.name = nil
      expect(branch.valid?).to eq(false)
    end

    it 'should not be valid without contact no' do
      branch.contact_no = nil
      expect(branch.valid?).to eq(false)
    end

    it 'should not be valid with invalid contact no' do
      branch.contact_no = 12345
      expect(branch.valid?).to eq(false)
    end

    it 'should not be valid without address' do
      branch.address = nil
      expect(branch.valid?).to eq(false)
    end

    it 'should not be valid without ifsc' do
      branch.ifsc = nil
      expect(branch.valid?).to eq(false)
    end

  end
end
