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

ActiveRecord::Schema.define(version: 20150701171220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "partner_id",               null: false
    t.integer  "practice_id",              null: false
    t.date     "schedule_dt",              null: false
    t.time     "schedule_tm",              null: false
    t.integer  "contact_type", default: 0, null: false
    t.integer  "outcome",      default: 0, null: false
    t.date     "outcome_dt"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "events", ["partner_id"], name: "index_events_on_partner_id", using: :btree
  add_index "events", ["practice_id"], name: "index_events_on_practice_id", using: :btree

  create_table "partners", force: :cascade do |t|
    t.integer  "site_id",                             null: false
    t.string   "name",                                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "partners", ["email"], name: "index_partners_on_email", unique: true, using: :btree
  add_index "partners", ["reset_password_token"], name: "index_partners_on_reset_password_token", unique: true, using: :btree
  add_index "partners", ["site_id"], name: "index_partners_on_site_id", using: :btree
  add_index "partners", ["unlock_token"], name: "index_partners_on_unlock_token", unique: true, using: :btree

  create_table "personnels", force: :cascade do |t|
    t.integer  "practice_id",                            null: false
    t.string   "name",                                   null: false
    t.integer  "role"
    t.string   "phone1",      limit: 20
    t.boolean  "phone1_best",            default: false, null: false
    t.string   "phone2",      limit: 20
    t.boolean  "phone2_best",            default: false, null: false
    t.string   "email1",      limit: 20
    t.boolean  "email1_best",            default: false, null: false
    t.string   "email2",      limit: 20
    t.boolean  "email2_best",            default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "personnels", ["practice_id"], name: "index_personnels_on_practice_id", using: :btree

  create_table "practices", force: :cascade do |t|
    t.integer  "partner_id",                         null: false
    t.string   "name",                               null: false
    t.string   "address"
    t.string   "phone"
    t.string   "url"
    t.integer  "status",             default: 0,     null: false
    t.boolean  "primary_care",       default: false, null: false
    t.integer  "md_fte",             default: 0,     null: false
    t.boolean  "emr_certified",      default: false, null: false
    t.integer  "emr_certified_year", default: 0,     null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "practices", ["partner_id"], name: "index_practices_on_partner_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "partners"
  add_foreign_key "events", "practices"
  add_foreign_key "partners", "sites"
  add_foreign_key "personnels", "practices"
  add_foreign_key "practices", "partners"
end
