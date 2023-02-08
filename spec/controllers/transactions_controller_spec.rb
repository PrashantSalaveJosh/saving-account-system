require 'rails_helper'
require 'support/factory_bot'

RSpec.describe TransactionsController, type: :controller do
  context 'GET /transactions' do
    let!(:role) { create :role, name: "Customer", key: "customer" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    let!(:account) { create :account, user: valid_user, branch: branch }
    let!(:transaction) { create :transaction, account: account }

    before do
      sign_in(valid_user)
    end

    it 'should return all transactions of user' do
      get :index, params: { user_id: valid_user.id }
      expect(response.status).to eq(200)
      res = (JSON.parse(response.body)[0])
      expect(res['transaction_type']).to be_present
      expect(res['details']).to be_present
      expect(res['amount']).to be_present
      expect(res['balance']).to be_present
      expect(res['account_id']).to be_present
    end
  end

  context 'GET /show' do
    let!(:role) { create :role, name: "Customer", key: "customer" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    let!(:account) { create :account, user: valid_user, branch: branch }
    let!(:transaction) { create :transaction, account: account }

    before do
      sign_in(valid_user)
    end

    it 'should successfully show transaction' do
      get :show, params: { id: transaction.id }
      expect(response.status).to eq(200)
    end

    it 'should not show transaction with different transaction id' do
      get :show, params: { id: Faker::Number.number(digits: 2) }
      expect((response.status)).to eq(404)
    end
  end

  context 'POST /transactions' do
    let!(:role) { create :role, name: "Customer", key: "customer" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }
    let!(:account) { create :account, user: valid_user, branch: branch }
    
    before do
      sign_in(valid_user)
    end

    it "creates a new transaction" do
      post :create, params: { transaction: {
        transaction_type: 'credit',
        details: 'Netbanking',
        amount: Faker::Number.number( digits: 4 ),
        account_id: account
        }
      }
      expect(response.status).to eq(201)
      expect((JSON.parse(response.body))['message']).to eq(I18n.t('transaction.create.success'))
    end

    it "should not create new transaction with nil field" do
      post :create, params: { transaction: {
        transaction_type: nil,
        details: 'Netbanking',
        amount: Faker::Number.number( digits: 4 ),
        account_id: account
        }
      }
      expect(response.status).to eq(422)
      expect((JSON.parse(response.body))['message']).to eq(I18n.t('transaction.create.failure'))
    end
  end
end