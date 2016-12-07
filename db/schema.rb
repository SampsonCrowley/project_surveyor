# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161207023825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "multiple_choices", force: :cascade do |t|
    t.integer  "options_count", default: 0
    t.boolean  "multi"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer  "multiple_choice_id"
    t.string   "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["multiple_choice_id"], name: "index_options_on_multiple_choice_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "survey_id"
    t.string   "category_type"
    t.integer  "category_id"
    t.string   "question"
    t.integer  "order"
    t.boolean  "required"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["category_type", "category_id"], name: "index_questions_on_category_type_and_category_id", using: :btree
    t.index ["survey_id"], name: "index_questions_on_survey_id", using: :btree
  end

  create_table "range_choices", force: :cascade do |t|
    t.integer  "min",        default: 0
    t.integer  "max"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer  "survey_id"
    t.json     "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_results_on_survey_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "options", "multiple_choices"
  add_foreign_key "questions", "surveys"
  add_foreign_key "results", "surveys"
end
