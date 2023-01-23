require 'rails_helper'

RSpec.describe CreateJournalEntry do

  let(:service) { described_class.new }
  let!(:account_1) { FactoryBot.create(:account, balance_cents: 10000) }
  let!(:account_2) { FactoryBot.create(:account, balance_cents: 5000) }
  let!(:amount_cents) { 2000 }
  let!(:transaction) { Transaction.create!(source_account_id: account_1.id, destination_account_id: account_2.id, amount_cents: amount_cents, transaction_type: Transaction.transaction_types[:transfer])}

  describe '#call' do
    it 'When Transfer funds from source account to destination account successful, journal entry and posting created successfully' do
      CreateJournalEntry.new(transaction_id: transaction.id).call
      expect(Journal.count).to eq 1
      expect(Posting.count).to eq 2
      expect(Posting.first.journal.id).to eq Journal.first.id
      expect(Posting.last.journal.id).to eq Journal.first.id
    end
  end
end