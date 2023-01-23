class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.bigint :amount_cents
      t.string :currency, default: "USD"
      t.integer :source_account_id
      t.integer :destination_account_id
      t.integer :transaction_type
      t.integer :status

      t.timestamps
    end

    add_index :transactions, :source_account_id
    add_index :transactions, :destination_account_id

  end
end
