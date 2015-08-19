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

ActiveRecord::Schema.define(version: 20150819152150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "partner_id",                                       null: false
    t.integer  "practice_id",                                      null: false
    t.date     "schedule_dt",                                      null: false
    t.time     "schedule_tm"
    t.integer  "contact_type",                     default: 0,     null: false
    t.integer  "outcome",                          default: 0,     null: false
    t.text     "description"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "current_partner"
    t.string   "contact_type_other"
    t.boolean  "outcome_pal_sent",                 default: false
    t.boolean  "outcome_pal_returned",             default: false
    t.boolean  "outcome_complete_ehr",             default: false
    t.boolean  "outcome_complete_characteristics", default: false
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
    t.integer  "practice_id",                                       null: false
    t.string   "name",                                              null: false
    t.integer  "role"
    t.string   "phone1",                 limit: 20
    t.boolean  "phone1_best",                       default: false, null: false
    t.string   "phone2",                 limit: 20
    t.boolean  "phone2_best",                       default: false, null: false
    t.string   "email1",                 limit: 20
    t.boolean  "email1_best",                       default: false, null: false
    t.string   "email2",                 limit: 20
    t.boolean  "email2_best",                       default: false, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "current_partner"
    t.boolean  "ehr_extractor",                     default: false
    t.boolean  "ehr_helper",                        default: false
    t.boolean  "ehr_cqm",                           default: false
    t.string   "role_other"
    t.boolean  "site_contact_primary",              default: false
    t.boolean  "site_contact_secondary",            default: false
    t.boolean  "site_contact_champion",             default: false
  end

  add_index "personnels", ["practice_id"], name: "index_personnels_on_practice_id", using: :btree

  create_table "practices", force: :cascade do |t|
    t.integer  "partner_id",                                                   null: false
    t.string   "name",                                                         null: false
    t.string   "address"
    t.string   "phone"
    t.string   "url"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "email"
    t.integer  "recruitment_source"
    t.string   "recruitment_source_referral"
    t.integer  "prac_ehr_yr"
    t.integer  "prac_ehrname"
    t.string   "prac_ehrname_other"
    t.string   "prac_ehrversion"
    t.integer  "prac_ehr_mu"
    t.integer  "prac_mu_stage1"
    t.integer  "prac_mu_stage2"
    t.integer  "prac_ehr_extractdata"
    t.integer  "prac_ehr_person_extractdata"
    t.string   "prac_ehr_person_extractdata_other"
    t.integer  "prac_it_support"
    t.integer  "prac_ehr_vendor"
    t.integer  "prac_share_healthinfo"
    t.integer  "prac_cqm"
    t.integer  "prac_cqm_submit"
    t.string   "prac_cqm_who"
    t.integer  "prac_ehr_satisfaction"
    t.integer  "prac_new_ehr"
    t.integer  "number_clinicians"
    t.float    "fte_clinicians"
    t.string   "prac_own_other_specify"
    t.integer  "prac_own_yrs"
    t.integer  "elig_clinic_count"
    t.integer  "prac_spec_mix"
    t.integer  "prac_pcmh"
    t.integer  "prac_aco_join_medicaid"
    t.text     "interest_why"
    t.text     "interest_expect"
    t.text     "interest_challenge"
    t.integer  "primary_care"
    t.integer  "prac_ehr"
    t.integer  "prac_ehr_mu_yr"
    t.integer  "interest_yn"
    t.integer  "interest_why_not"
    t.string   "interest_why_not_other"
    t.string   "current_partner"
    t.string   "parent_organization"
    t.integer  "interest_contact_month"
    t.integer  "prac_state"
    t.boolean  "prac_own_clinician",                           default: false
    t.boolean  "prac_own_hosp",                                default: false
    t.boolean  "prac_own_hmo",                                 default: false
    t.boolean  "prac_own_fqhc",                                default: false
    t.boolean  "prac_own_nonfed",                              default: false
    t.boolean  "prac_own_academic",                            default: false
    t.boolean  "prac_own_fed",                                 default: false
    t.boolean  "prac_own_rural",                               default: false
    t.boolean  "prac_own_ihs",                                 default: false
    t.boolean  "prac_own_other",                               default: false
    t.boolean  "prac_aco_medicaid",                            default: false
    t.boolean  "prac_aco_medicare",                            default: false
    t.boolean  "prac_aco_commercial",                          default: false
    t.boolean  "prac_aco_other",                               default: false
    t.boolean  "prac_aco_none",                                default: false
    t.boolean  "prac_aco_dk",                                  default: false
    t.integer  "prac_aco_join_medicare"
    t.integer  "prac_aco_join_commercial"
    t.string   "zip_code",                          limit: 10
  end

  add_index "practices", ["partner_id"], name: "index_practices_on_partner_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "events", "partners"
  add_foreign_key "events", "practices"
  add_foreign_key "partners", "sites"
  add_foreign_key "personnels", "practices"
  add_foreign_key "practices", "partners"
end
