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

ActiveRecord::Schema[8.0].define(version: 2025_07_12_185553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "payments", force: :cascade do |t|
    t.bigint "amount_cents", null: false
    t.uuid "correlation_id", null: false
    t.bigint "processor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["correlation_id"], name: "index_payments_on_correlation_id", unique: true
    t.index ["processor_id"], name: "index_payments_on_processor_id"
  end

  create_table "processor_statuses", force: :cascade do |t|
    t.string "min_response_time", null: false
    t.boolean "failing_status", default: false, null: false
    t.bigint "processor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["processor_id"], name: "index_processor_statuses_on_processor_id"
  end

  create_table "processors", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "fee_rate", precision: 5, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "payments", "processors"
  add_foreign_key "processor_statuses", "processors"
end
