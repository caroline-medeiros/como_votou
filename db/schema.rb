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

ActiveRecord::Schema[8.1].define(version: 2025_12_17_020653) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "deputies", force: :cascade do |t|
    t.string "api_id"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.bigint "party_id", null: false
    t.string "photo_url"
    t.string "state"
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_deputies_on_api_id"
    t.index ["party_id"], name: "index_deputies_on_party_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "acronym"
    t.string "api_id"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_parties_on_api_id"
  end

  create_table "propositions", force: :cascade do |t|
    t.string "api_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["api_id"], name: "index_propositions_on_api_id"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "deputy_id", null: false
    t.datetime "updated_at", null: false
    t.string "vote_type"
    t.bigint "voting_id", null: false
    t.index ["deputy_id"], name: "index_votes_on_deputy_id"
    t.index ["voting_id", "deputy_id"], name: "index_votes_on_voting_id_and_deputy_id", unique: true
    t.index ["voting_id"], name: "index_votes_on_voting_id"
  end

  create_table "votings", force: :cascade do |t|
    t.string "api_id"
    t.datetime "created_at", null: false
    t.datetime "datetime"
    t.text "description"
    t.string "news_title"
    t.bigint "proposition_id"
    t.string "result"
    t.text "summary"
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_votings_on_api_id"
    t.index ["proposition_id"], name: "index_votings_on_proposition_id"
  end

  add_foreign_key "deputies", "parties"
  add_foreign_key "votes", "deputies"
  add_foreign_key "votes", "votings"
  add_foreign_key "votings", "propositions"
end
