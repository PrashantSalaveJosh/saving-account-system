require 'rails_helper'
require 'support/factory_bot'

RSpec.describe AccountsController, type: :controller do
  context 'GET /accounts' do
    let!(:role) { create :role, name: "Admin", key: "admin" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    let!(:account) { create :account, user: valid_user, branch: branch }

    before do
      sign_in(valid_user)
    end

    it 'should return all users account details' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET /show' do
    let!(:role) { create :role, name: "Customer", key: "customer" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    let!(:account) { create :account, user: valid_user, branch: branch }

    before do
      sign_in(valid_user)
    end

    it 'should successfully show account details' do
      get :show, params: { id: account.id }
      expect(response.status).to eq(200)
    end

    it 'should not show account details with different account id' do
      get :show, params: { id: Faker::Number.number(digits: 2) }
      expect((response.status)).to eq(404)
    end
  end

  context 'POST /accounts' do
    let!(:role) { create :role, name: "Admin", key: "admin" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    # let!(:account) { create :account, user: valid_user, branch: branch }
    
    before do
      sign_in(valid_user)
    end

    it "creates a new account" do
      post :create, params: { account: {
        account_no: Faker::Bank.account_number(digits: 9),
        account_type: 'saving',
        total_balance: Faker::Number.number(digits: 4),
        user_id: valid_user.id,
        branch_id: branch.id
        }
      }
      expect(response.status).to eq(201)
    end

    it "should not create new account with nil field" do
      post :create, params: { account: {
        account_no: Faker::Bank.account_number(digits: 9),
        account_type: nil,
        total_balance: Faker::Number.number(digits: 4),
        user_id: valid_user.id,
        branch_id: nil
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context 'PUT update' do
    let!(:role) { create :role, name: "Admin", key: "admin" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    let!(:account) { create :account, user: valid_user, branch: branch }

    before do
      sign_in(valid_user)
    end

    it 'should update account' do
      put :update, params: {
        account: {
          account_no: Faker::Bank.account_number(digits: 9),
          account_type: 'saving',
          total_balance: Faker::Number.number(digits: 4),
          user_id: valid_user.id,
          branch_id: branch.id
        }, id: account.id
      }
      expect(response.status).to eq(200)
    end

    it 'should not update the account with nil field' do
      put :update, params: {
        account: {
          account_no: Faker::Bank.account_number(digits: 9),
          account_type: nil,
          total_balance: Faker::Number.number(digits: 4),
          user_id: valid_user.id,
          branch_id: branch.id
        }, id: account.id
      }
      expect(response.status).to eq(422)
    end

    it 'should not update the account with different id' do
      put :update, params: {
        account: {
          account_no: Faker::Bank.account_number(digits: 9),
          account_type: 'saving',
          total_balance: Faker::Number.number(digits: 4),
          user_id: valid_user.id,
          branch_id: branch.id
        }, id: Faker::Number.number(digits: 2)
      }
      expect(response.status).to eq(404)
    end
  end

end