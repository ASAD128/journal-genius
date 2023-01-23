require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:account_1) { Account.create!(name: "Asad", balance_cents: 10000, account_number: "00002222" ) }
  let!(:account_2) { Account.create!(name: "Mikey", balance_cents: 5000, account_number: "00004444" ) }

  subject {
    described_class.new(source_account_id: account_1.id, destination_account_id: account_2.id, amount_cents: 2000)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
