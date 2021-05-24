# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statement, type: :model do
  context 'Validates' do
    it 'is valid with all required fields' do
      user = FactoryBot.create(:user)
      statement = Statement.new(action: 'DEPÓSITO', user_id: user.id, balance: 10.0)
      statement.valid?
      expect(statement).to be_valid
    end
    it 'is invalid without action' do
      is_expected.to validate_length_of(:action)
    end
    it 'is invalid without balance' do
      is_expected.to validate_length_of(:balance)
    end
    it 'is invalid without user_id' do
      is_expected.to validate_length_of(:user_id)
    end
  end
end
