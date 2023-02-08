require 'swagger_helper'

RSpec.describe 'branches', type: :request do

  path '/branches' do

    get('list branches') do
      tags 'branches'
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
  
end
