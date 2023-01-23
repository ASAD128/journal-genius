class Journal < ApplicationRecord
  has_many :postings
  enum entry_type: [:transfer, :deposit, :withdraw]
end
