require 'rails_helper'
require 'support/factory_bot'

RSpec.describe BranchesController, type: :controller do
  context 'GET /branches' do
    let!(:role) { create :role, name: "Admin", key: "admin" }
    let!(:valid_user) { create :user, role: role }
    let!(:branch) { create :branch }

    before do
      sign_in(valid_user)
    end

    it 'should return all branches details' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end