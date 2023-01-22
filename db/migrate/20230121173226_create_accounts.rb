class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name,              null: false, default: ""
      t.integer :user_id
      t.string :account_number,              null: false, default: ""
      t.bigint :balance_cents
      t.string :currency

      t.timestamps
    end

    add_index :accounts, :account_number, unique: true

  end
end
