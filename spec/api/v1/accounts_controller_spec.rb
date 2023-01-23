require 'rails_helper'

RSpec.describe Api::V1::AccountsController do

  let!(:account_1) { FactoryBot.create(:account, balance_cents: 10000) }
  let!(:account_2) { FactoryBot.create(:account, balance_cents: 5000) }
  let!(:account_3) { 11111 }
  let!(:amount_cents) { 2000 }

  describe "#Index" do
    it "Would return all the accounts" do
      get '/api/v1/accounts'
      expect(response).to be_successful
      result = JSON.parse(response.body)
      expect(result['status']).to eq 200
    end
  end

  describe "#Show" do
    it "return the account with specific ID" do
      get "/api/v1/accounts/#{account_1.id}"
      expect(response).to be_successful
      result = JSON.parse(response.body)
      expect(result['status']).to eq 200
      expect(result['account_balance'].present?).to eq true
      expect(result['transactions'].present?).to eq true
    end

    it "return error when account with specific ID not exists" do
      get "/api/v1/accounts/#{account_3}"
      result = JSON.parse(response.body)
      expect(result['status']).to eq 404
    end
  end
end