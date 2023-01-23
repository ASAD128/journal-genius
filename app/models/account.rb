class Account < ApplicationRecord
  has_many :postings
  monetize :balance_cents, with_currency: :usd
end
