require 'swagger_helper'

RSpec.describe 'transactions', type: :request do

  path '/transactions?user_id={id}' do

    get('list transactions') do
      tags 'transactions'
      parameter name: 'user_id', in: :query, type: :string, description: 'id'

      # parameter in: :query, schema: {
      #   user_id: { type: :integer }
      # }

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

  path '/transactions' do
    
    post('create transaction') do
      tags 'transactions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :transaction, in: :body, schema: {
        type: :object,
        properties: {
          transaction: {
            type: :object,
            properties: {
              transaction_type: { type: :string },
              details: { type: :string },
              amount: { type: :float },
              account_id: { type: :integer }
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

  path '/transactions/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show transaction') do
      tags 'transactions'
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

  end
end
