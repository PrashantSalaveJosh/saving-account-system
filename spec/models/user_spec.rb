require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating user ' do
    let(:user) { build :user }

    it 'should be valid user with valid parameters' do
      expect(user.valid?).to eq(true)
    end

    it 'should not be valid with invalid email' do
      user.email = '123'
      expect(user.valid?).to eq(false)
    end

    it 'should not save user with email field missing' do
      user.email = nil
      expect(user.valid?).to eq(false)
    end

    it 'should not valid without password' do
      user.password = nil
      expect(user.valid?).to eq(false)
    end

    # it 'should not valid without first_name' do
    #   user.first_name = nil
    #   debugger
    #   expect(user.valid?).to eq(false)
    # end

    # it 'should not valid without last_name' do
    #   user.last_name = nil
    #   expect(user.valid?).to eq(false)
    # end

    # it 'should have valid contact_no' do
    #   expect(user.contact_no.length).to eq(10)
    # end

    # it 'should not valid without contact_no' do
    #   user.contact_no = nil
    #   expect(user.valid?).to eq(false)
    # end

    # it 'should not valid without address' do
    #   user.address = nil
    #   expect(user.valid?).to eq(false)
    # end

    # it 'should not valid without dob' do
    #   user.dob = nil
    #   expect(user).to_not be_valid
    # end

    # it 'should not valid without gender' do
    #   user.gender = nil
    #   expect(user).to_not be_valid
    # end
  end
end
