class Posting < ApplicationRecord
  belongs_to :journal
  belongs_to :account
end
