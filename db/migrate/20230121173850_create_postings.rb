class CreatePostings < ActiveRecord::Migration[7.0]
  def change
    create_table :postings do |t|
      t.bigint :amount_cents
      t.string :currency
      t.integer :account_id
      t.integer :journal_id

      t.timestamps
    end
  end
end
