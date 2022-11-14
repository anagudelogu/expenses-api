require 'swagger_helper'
# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe 'users/sessions' do
  path '/login' do
    post('Authenticate user') do
      tags 'Authentication'
      description 'Authenticates an user and returns a JWT'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string },
            },
            required: %w[email password],
          },
        },
      }

      let(:u) { create(:user) }

      response(200, 'authenticated') do
        let(:params) { { user: { email: u.email, password: u.password } } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data[:data]).to eq({ name: u.name, email: u.email, created_date: u.created_at.strftime('%d/%m/%Y') })
        end
      end

      response(401, 'unauthorized') do
        let(:params) { { user: { email: 'invalid email', password: 'invalid password' } } }

        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
