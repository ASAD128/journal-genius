class CreateJournals < ActiveRecord::Migration[7.0]
  def change
    create_table :journals do |t|
      t.integer :transaction_id
      t.integer :entry_type

      t.timestamps
    end

    add_index :journals, :transaction_id,                unique: true
  end
end
