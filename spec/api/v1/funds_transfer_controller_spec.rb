require 'rails_helper'

RSpec.describe Api::V1::FundsTransferController do

  let!(:account_1) { FactoryBot.create(:account, balance_cents: 10000) }
  let!(:account_2) { FactoryBot.create(:account, balance_cents: 5000) }
  let!(:account_3) { 11111 }
  let!(:amount_cents) { 2000 }

  describe "#Post" do
    it "would transfer funds between the accounts" do
      post '/api/v1/funds_transfer', params: {source_account: account_1.id, destination_account: account_2.id, amount_cents: amount_cents}
      expect(response).to be_successful
      result = JSON.parse(response.body)
      expect(result['status']).to eq 204
    end

    it "would fail the funds transfer when account not found" do
      post '/api/v1/funds_transfer', params: {source_account: account_3, destination_account: account_2.id, amount_cents: amount_cents}
      result = JSON.parse(response.body)
      expect(result['status']).to eq 500
    end
  end
end