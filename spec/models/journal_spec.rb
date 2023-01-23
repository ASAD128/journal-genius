require 'rails_helper'

RSpec.describe Journal, type: :model do

  let!(:account_1) { Account.create(balance_cents: 10000 ) }
  let!(:account_2) { Account.create(balance_cents: 5000 ) }
  let!(:transaction) { Transaction.create(source_account_id: account_1.id, destination_account_id: account_2.id, amount_cents: 2000) }

  subject {
    described_class.new(transaction_id: transaction)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
