# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151028200419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.text     "body",                               null: false
    t.string   "url",        limit: 255,             null: false
    t.json     "author"
    t.json     "raw_data"
    t.datetime "created_at"
    t.datetime "fetched_at"
    t.integer  "state",                  default: 0, null: false
    t.integer  "source_id",                          null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string  "name"
    t.text    "query",                    null: false
    t.text    "context"
    t.text    "stopwords"
    t.boolean "active",    default: true
  end

end
