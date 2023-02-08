require 'swagger_helper'

RSpec.describe 'accounts', type: :request do

  path '/accounts' do

    get('list accounts') do
      tags 'accounts'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create account') do
      tags 'accounts'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :account, in: :body, schema: {
        type: :object,
        properties: {
          account: {
            type: :object,
            properties: {
              account_type: { type: :string },
              total_balance: { type: :float },
              user_id: { type: :integer },
              branch_id: { type: :integer }
            }
          }
        }
        # required: %w[user email password]
      }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/accounts/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show account') do
      tags 'accounts'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    # patch('update account') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    put('update account') do
      tags 'accounts'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :account, in: :body, schema: {
        type: :object,
        properties: {
          account: {
            type: :object,
            properties: {
              account_type: { type: :string },
              total_balance: { type: :float },
              user_id: { type: :integer },
              branch_id: { type: :integer }
            }
          }
        }
        # required: %w[user email password]
      }
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    # delete('delete account') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end
end
