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
      res = (JSON.parse(response.body)[0])
      expect(res['name']).to be_present
      expect(res['contact_no']).to be_present
      expect(res['address']).to be_present
      expect(res['ifsc']).to be_present
    end
  end
end