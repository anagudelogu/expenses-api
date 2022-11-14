require 'swagger_helper'
# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe 'users/sessions' do
  let(:u) { create(:user) }

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

      response(200, 'authenticated') do
        let(:params) { { user: { email: u.email, password: u.password } } }

        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data[:data]).to eq({ name: u.name, email: u.email, created_date: u.created_at.strftime('%d/%m/%Y') })
        end
      end

      response(401, 'unauthorized') do
        let(:params) { { user: { email: 'invalid email', password: 'invalid password' } } }

        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data[:errors]).to eq([{ status: '401', title: 'Invalid Email or password.' }])
        end
      end
    end
  end

  path '/logout' do
    delete('Revoke active JWT') do
      tags 'Authentication'
      description "Revokes an user's active JWT"
      consumes 'application/json'
      security [bearer_auth: []]

      response(200, 'successful logout') do
        let(:Authorization) { get_jwt_for(u) }

        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data[:data]).to match(/logged out/i)
        end
      end

      response(401, 'No active session') do
        let(:Authorization) { 'invalid token' }

        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data).to eq({ errors: [{ status: '401', title: "Couldn't find an active session." }] })
        end
      end
    end
  end

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true),
      },
    }
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
