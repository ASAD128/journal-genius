class Account < ApplicationRecord
  validates :name, presence: true
  has_many :postings
  monetize :balance_cents, with_currency: :usd
end
