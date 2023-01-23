class TransferFunds

  attr_reader :source_account, :destination_account, :amount_cents, :transaction_type

  def initialize(source_account:, destination_account:, amount_cents:, transaction_type: 'transfer')
    @source_account = Account.find_by(id: source_account.to_i)
    @destination_account = Account.find_by(id: destination_account.to_i)
    @amount_cents = amount_cents.to_i
    @transaction_type = transaction_type
  end

  def call
      result = create_transaction
      if result[:success] == true
        create_journal_entry
        update_account_balances
        return success
      else
        return fail("Transaction not successful")
      end

  rescue ActiveRecord::RecordInvalid => e
    return fail(e)
  end

  private

  def create_transaction
    if @source_account.present? && @destination_account.present?
      @transaction = Transaction.create!(
        amount_cents: amount_cents,
        source_account_id: source_account.id,
        destination_account_id: destination_account.id,
        status: Transaction.statuses[:processing],
        transaction_type: transaction_type
      )
      success
    else
      fail("Source or destination account not found")
    end
  end

  def create_journal_entry
    CreateJournalEntry.new(transaction_id: @transaction.id).call
  end

  def update_account_balances
    # this can be done from postings balance (postings.sum(:amount_cents)) or directly updating balance from current transaction
    # it depends upon the requirements for now updating balance directly from transaction but if there's mismatch between
    # account balance and postings double entry transaction status would n't be successful, it's would be under review and
    # admin/accountant can reconcile that transaction later
    debit_balance_from_source_account
    credit_amount_to_destination_account
    validate_account_balances
  end

  def validate_account_balances
    if (@source_account.balance_cents == @source_account.postings.sum(:amount_cents)) && (@destination_account.balance_cents == @destination_account.postings.sum(:amount_cents))
      @transaction.update(status: Transaction.statuses[:successful])
    else
      @transaction.update(status: Transaction.statuses[:under_review])
    end
  end

  def debit_balance_from_source_account
    @source_account.balance_cents -= amount_cents
    @source_account.save!
  end

  def credit_amount_to_destination_account
    @destination_account.balance_cents += amount_cents
    @destination_account.save!
  end

  def update_transaction_status
    @transaction.update(status: Transaction.statuses[:successful])
  end

  def success
    result = {}
    result[:message] = "Fund Transfer successful"
    result[:status] = 204
    result[:success] = true
    return result
  end

  def fail(message)
    result = {}
    result[:message] = message
    result[:status] = 500
    result[:success] = false
    return result
  end
end
