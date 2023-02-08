# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'

RSpec.describe Users::SessionsController, type: :controller do
  context 'POST /login' do
    let(:user) { create :user }
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    it 'should sign in with valid credintials' do
      post :create, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
      debugger
      expect(response.status).to eq(200)
      expect((JSON.parse(response.body))['message']).to eq(I18n.t('user.login.success'))
    end

    it 'should not sign in with invalid credintials' do
      post :create, params: {
        user: {
          email: user.email,
          password: '123'
        }
      }
      debugger
      expect(response.status).to eq(401)
    end
  end

end