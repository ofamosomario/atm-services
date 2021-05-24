# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validates' do
    it 'is valid with all required fields' do
      user = FactoryBot.create(:user)
      user.valid?
      expect(user).to be_valid
    end
    it 'is invalid without email' do
      is_expected.to validate_length_of(:email)
    end
    it 'is invalid wrong email syntax' do
      user = FactoryBot.build(:user, email: Faker::Internet::username)
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end
    it 'is invalid without full_name' do
      is_expected.to validate_length_of(:full_name)
    end
    it 'is invalid without password and password confirmation' do
      is_expected.to validate_length_of(:password)
    end
    it 'is invalid with full_name too long' do
      user = FactoryBot.build(:user, full_name: Faker::Lorem.words(number: 71))
      should validate_length_of(user), in: 5..70, too_long: 'is too long (maximum is 70 characters)'
    end
    it 'is invalid with password too long' do
      user = FactoryBot.build(:user, password: Faker::Lorem.words(number: 71))
      should validate_length_of(user), in: 5..70, too_long: 'is too long (maximum is 70 characters)'
    end
  end
end
