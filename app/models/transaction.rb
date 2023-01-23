class Transaction < ApplicationRecord
  enum status: [:processing, :successful, :failed, :under_review]
  enum transaction_type: [:transfer, :deposit, :withdraw]
end
