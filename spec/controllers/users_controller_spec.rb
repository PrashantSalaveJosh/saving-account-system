require 'rails_helper'
require 'support/factory_bot'

RSpec.describe UsersController, type: :controller do
  context 'GET /users' do
    let!(:role) { create :role, name: "Admin", key: "admin" }
    let!(:valid_user) { create :user, role: role }

    before do
      sign_in(valid_user)
    end

    it 'should return all users details' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET /show' do
    let!(:role) { create :role, name: "Customer", key: "customer" }
    let!(:user) { create :user, role: role }

    before do
      sign_in(user)
    end

    it 'should successfully show user' do
      get :show, params: { id: user.id }
      expect(response.status).to eq(200)
    end

    it 'should not show user with different user id' do
      get :show, params: { id: Faker::Number.number(digits: 2) }
      expect((response.status)).to eq(404)
    end
  end

  context 'POST /users' do
    let!(:role) { create :role, name: "Admin", key: "admin" }
    let!(:role2) { create :role, name: "Customer", key: "customer" }
    let!(:valid_user) { create :user, role: role }
    
    before do
      sign_in(valid_user)
    end

    it "creates a new user" do
      post :create, params: { user: {
        email: Faker::Internet.email,
        password: Faker::Internet.password
        }
      }
      expect(response.status).to eq(201)
    end

    it "should not create new user without email" do
      post :create, params: {user: {
        email: nil,
        password: '123456'
      }}
      expect(response.status).to eq(422)
    end

    it "should not create new user without password" do
      post :create, params: {user: {
        email: 'prb@mail.com',
        password: nil
      }}
      expect(response.status).to eq(422)
    end
  end

  context 'PUT update' do
    let!(:role) { create :role, name: "Customer", key: "customer" }
    let!(:user) { create :user, role: role }

    before do
      sign_in(user)
    end

    it 'should update user' do
      put :update, params: {
        user: {
          email: Faker::Internet.email,
          password: Faker::Internet.password,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          contact_no: Faker::Number.number(digits: 10),
          address: Faker::Address.full_address,
          dob: Faker::Date.in_date_period,
          gender: Faker::Gender.binary_type
        }, id: user.id
      }
      expect(response.status).to eq(200)
    end

    it 'should not update the user with nil field' do
      put :update, params: {
        user: {
          email: Faker::Internet.email,
          password: Faker::Internet.password,
          first_name: nil,
          last_name: Faker::Name.last_name,
          contact_no: Faker::Number.number(digits: 10),
          address: Faker::Address.full_address,
          dob: Faker::Date.in_date_period,
          gender: Faker::Gender.binary_type
        }, id: user.id
      }
      expect(response.status).to eq(422)
    end

    it 'should not update the user with different id' do
      put :update, params: {
        user: {
          email: Faker::Internet.email,
          password: Faker::Internet.password,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          contact_no: Faker::Number.number(digits: 10),
          address: Faker::Address.full_address,
          dob: Faker::Date.in_date_period,
          gender: Faker::Gender.binary_type
        }, id: Faker::Number.number(digits: 2)
      }
      expect(response.status).to eq(404)
    end
  end

end