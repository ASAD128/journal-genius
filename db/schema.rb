# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_21_173850) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "account_number", default: "", null: false
    t.bigint "balance_cents", default: 0
    t.string "currency", default: "USD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
  end

  create_table "journals", force: :cascade do |t|
    t.integer "transaction_id"
    t.integer "entry_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_journals_on_transaction_id", unique: true
  end

  create_table "postings", force: :cascade do |t|
    t.bigint "amount_cents"
    t.string "currency", default: "USD"
    t.integer "account_id"
    t.integer "journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "amount_cents"
    t.string "currency", default: "USD"
    t.integer "source_account_id"
    t.integer "destination_account_id"
    t.integer "transaction_type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_account_id"], name: "index_transactions_on_destination_account_id"
    t.index ["source_account_id"], name: "index_transactions_on_source_account_id"
  end

end
