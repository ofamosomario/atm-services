# frozen_string_literal: true

require 'rails_helper'
require 'shared_contexts'
RSpec.describe DashboardController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:target_user) { FactoryBot.create(:user) }
  describe '/deposit' do
    it 'when user realized a deposit' do
      sign_in user
      post :create_deposit, params: { user: { value: 10.0, user: user } }
      user.reload
      expect(user.balance).to be >= 10
    end
    it 'when user realized a deposit without value' do
      sign_in user
      post :create_deposit, params: { user: { value: nil, user: user } }
      expect(response.status).to eq(302)
    end
  end
  describe '/create_withdrawal' do
    it 'when user realized a withdrawal' do
      sign_in user
      post :create_deposit, params: { user: { value: 10.0, user: user } }
    end
    it 'when user realized a withdrawal without value' do
      sign_in user
      post :create_deposit, params: { user: { value: nil, user: user } }
      expect(response.status).to eq(302)
    end
    it 'when user balance is negative' do
      sign_in user
      post :create_deposit, params: { user: { value: -10.0, user: user } }
      expect(response.status).to eq(302)
    end
  end
  describe '/create_fund_transfer' do
    it 'when user realized a fund transfer to another user' do
      sign_in user
      post :create_deposit, params: { user: { value: 50.0, user: user } }
      post :create_fund_transfer, params: { user: { value: 10.0, target_user: target_user.id } }
      target_user.reload
      user.reload
      expect(target_user.balance).to be >= 10
    end
    it 'when user realized a fund transfer without a fund' do
      sign_in user
      post :create_deposit, params: { user: { value: 0.0, user: user } }
      post :create_fund_transfer, params: { user: { value: 10.0, target_user: target_user.id } }
      target_user.reload
      user.reload
      expect(response.status).to eq(302)
    end
  end
end
