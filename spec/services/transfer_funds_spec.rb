require 'rails_helper'

RSpec.describe TransferFunds do

  let(:service) { described_class.new }
  let!(:account_1) { FactoryBot.create(:account, balance_cents: 10000) }
  let!(:account_2) { FactoryBot.create(:account, balance_cents: 5000) }
  let!(:amount_cents) { 2000 }

  describe '#call' do
    it 'Transfer funds from source account to destination account' do
      result = TransferFunds.new(source_account: account_1.id, destination_account: account_2.id, amount_cents: amount_cents, transaction_type: Transaction.transaction_types[:transfer]).call
      expect(result[:success]).to eq true
      expect(Transaction.count).to eq 1
      expect(account_1.reload.balance_cents).to eq 8000
      expect(account_2.reload.balance_cents).to eq 7000
      expect(Journal.count).to eq 1
      expect(Posting.count).to eq 2
    end

    it 'Transfer fund not successful if source account to destination account is missing' do
      result = TransferFunds.new(source_account: nil, destination_account: account_2.id, amount_cents: amount_cents, transaction_type: Transaction.transaction_types[:transfer]).call
      expect(result[:success]).to eq false
      expect(Transaction.count).to eq 0
      expect(account_1.reload.balance_cents).to eq 10000
      expect(account_2.reload.balance_cents).to eq 5000
      expect(Journal.count).to eq 0
      expect(Posting.count).to eq 0
    end
  end
end