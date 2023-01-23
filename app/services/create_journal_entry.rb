class CreateJournalEntry
  def initialize(transaction_id:)
     @transaction = Transaction.find(transaction_id)
  end

  def call
    ActiveRecord::Base.transaction do
      create_journal
      post_debits
      post_credits
    rescue ActiveRecord::RecordInvalid => e
      return { error: e.message }
    end
  end

  private

  def create_journal
   @journal = Journal.create(transaction_id: @transaction.id)
  end

  def post_debits
    Posting.create!(
        account_id: @transaction.source_account_id,
        amount_cents: - @transaction.amount_cents,
        currency: @transaction.currency,
        journal_id: @journal.id
    )
  end

  def post_credits
    Posting.create!(
        account_id: @transaction.destination_account_id,
        amount_cents: @transaction.amount_cents,
        currency: @transaction.currency,
        journal: @journal
    )
  end
end
