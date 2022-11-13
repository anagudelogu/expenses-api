require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    context 'when name is blank' do
      it 'is not valid' do
        user = build(:user, name: '')
        expect(user).not_to be_valid
      end
    end
  end
end
