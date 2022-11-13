require 'swagger_helper'
# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe 'users/registrations' do
  let(:user) { create(:user) }

  path '/register' do
    post('create account') do
      tags 'Authentication'
      description 'Creates an account'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string },
              confirm_password: { type: :string },
            },
            required: %w[email name password confirm_password],
          },
        },
      }
      response(201, 'Created') do
        let(:u) { build(:user) }
        let(:params) { { user: { name: u.name, email: u.email, password: u.password, confirm_password: u.password } } }

        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data[:data]).to include email: u.email, name: u.name
        end
      end

      response(422, 'Invalid params') do
        context 'when email is already taken' do
          let(:params) { { user: attributes_for(:user, email: user.email) } }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['status']).to eq '422'
            expect(data['errors']).to contain_exactly 'Email has already been taken'
          end
        end

        context 'when email is blank' do
          let(:params) { { user: attributes_for(:user, email: '') } }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['status']).to eq '422'
            expect(data['errors']).to contain_exactly "Email can't be blank"
          end
        end

        context 'when name is blank' do
          let(:params) { { user: attributes_for(:user, name: '') } }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['status']).to eq '422'
            expect(data['errors']).to contain_exactly "Name can't be blank"
          end
        end

        context 'when password is blank' do
          let(:params) { { user: attributes_for(:user, password: '') } }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['status']).to eq '422'
            expect(data['errors']).to contain_exactly "Password can't be blank"
          end
        end

        context 'when password is less than 6 chars' do
          let(:params) { { user: attributes_for(:user, password: 'pass') } }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['status']).to eq '422'
            expect(data['errors']).to contain_exactly 'Password is too short (minimum is 6 characters)'
          end
        end
      end

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            examples: {
              example.metadata[:example_group][:description] => {
                value: JSON.parse(response.body, symbolize_names: true),
              },
            },
          },
        }
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
