require 'rails_helper'

RSpec.describe Posting, type: :model do
  let!(:account_1) { Account.create!(name: "Asad", balance_cents: 10000, account_number: "00002222" ) }
  let!(:account_2) { Account.create!(name: "Mikey", balance_cents: 5000, account_number: "00004444" ) }
  let!(:transaction) { Transaction.create(source_account_id: account_1.id, destination_account_id: account_2.id, amount_cents: 2000) }
  let!(:journal) { Journal.create(transaction_id: transaction.id ) }

  subject {
    described_class.new(journal_id: journal.id, account_id: account_1.id, amount_cents: transaction.amount_cents)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
