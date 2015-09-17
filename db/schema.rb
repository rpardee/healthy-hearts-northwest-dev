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

ActiveRecord::Schema.define(version: 20150916210806) do

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

  create_table "ivcontacts", force: :cascade do |t|
    t.integer  "contact_type"
    t.integer  "contact_specific"
    t.date     "contact_dt"
    t.integer  "contact_mode"
    t.integer  "contact_duration"
    t.text     "contact_comments"
    t.boolean  "topic_ehr_vendor"
    t.boolean  "topic_3rdparty_vendor"
    t.boolean  "topic_custom_query"
    t.boolean  "topic_validate_data"
    t.boolean  "topic_meaningful_use"
    t.boolean  "topic_cqm_report"
    t.boolean  "topic_data_error"
    t.boolean  "topic_coding"
    t.boolean  "topic_hit_display"
    t.boolean  "topic_reminder"
    t.boolean  "topic_pcmha"
    t.boolean  "topic_abcs"
    t.boolean  "topic_brainstorm"
    t.boolean  "topic_observe_flow"
    t.boolean  "topic_share"
    t.boolean  "topic_connect"
    t.boolean  "topic_resource"
    t.boolean  "topic_planning"
    t.boolean  "topic_workflow"
    t.boolean  "topic_roles"
    t.boolean  "topic_qi_support"
    t.boolean  "topic_consensus"
    t.boolean  "topic_review_data"
    t.boolean  "topic_qi_display"
    t.boolean  "topic_huddle"
    t.boolean  "topic_leadership"
    t.boolean  "topic_other"
    t.string   "topic_other_specify"
    t.integer  "milestone_evidence_progress"
    t.integer  "milestone_evidence_active"
    t.text     "milestone_evidence_discussed"
    t.integer  "milestone_data_progress"
    t.integer  "milestone_data_active"
    t.text     "milestone_data_discussed"
    t.integer  "milestone_qi_progress"
    t.integer  "milestone_qi_active"
    t.text     "milestone_qi_discussed"
    t.integer  "milestone_atrisk_progress"
    t.integer  "milestone_atrisk_active"
    t.text     "milestone_atrisk_discussed"
    t.integer  "milestone_task_progress"
    t.integer  "milestone_task_active"
    t.text     "milestone_task_discussed"
    t.integer  "milestone_selfmgmt_progress"
    t.integer  "milestone_selfmgmt_active"
    t.text     "milestone_selfmgmt_discussed"
    t.integer  "milestone_community_progress"
    t.integer  "milestone_community_active"
    t.text     "milestone_community_discussed"
    t.integer  "gyr"
    t.text     "gyr_notes"
    t.integer  "tier"
    t.integer  "pcqm_1"
    t.integer  "pcqm_2"
    t.integer  "pcqm_3"
    t.integer  "pcqm_4"
    t.integer  "pcqm_5"
    t.integer  "pcqm_6"
    t.integer  "pcqm_7"
    t.integer  "pcqm_8"
    t.integer  "pcqm_9"
    t.integer  "pcqm_10"
    t.integer  "pcqm_11"
    t.integer  "pcqm_12"
    t.integer  "pcqm_13"
    t.integer  "pcqm_14"
    t.integer  "pcqm_15"
    t.integer  "pcqm_16"
    t.integer  "pcqm_17"
    t.integer  "pcqm_18"
    t.integer  "pcqm_19"
    t.integer  "pcqm_20"
    t.integer  "pcqm_21"
    t.integer  "pcqm_22"
    t.integer  "pcqm_23"
    t.integer  "pcqm_24"
    t.integer  "pcqm_25"
    t.integer  "pcqm_26"
    t.integer  "pcqm_27"
    t.integer  "pcqm_28"
    t.integer  "pcqm_29"
    t.integer  "pcqm_30"
    t.integer  "pcqm_31"
    t.integer  "pcqm_32"
    t.integer  "pcqm_33"
    t.integer  "pcqm_34"
    t.integer  "pcqm_35"
    t.integer  "pcqm_36"
    t.integer  "prac_change_ehr"
    t.integer  "prac_change_newlocation"
    t.integer  "prac_change_lost_clin"
    t.integer  "prac_change_lost_om"
    t.integer  "prac_change_boughtover"
    t.integer  "prac_change_billing"
    t.integer  "prac_change_other"
    t.text     "prac_change_specify"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "partners", force: :cascade do |t|
    t.integer  "site_id",                             null: false
    t.string   "name",                                null: false
    t.integer  "role",                   default: 0,  null: false
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
    t.integer  "practice_id",                                        null: false
    t.string   "name",                                               null: false
    t.integer  "role"
    t.string   "phone1",                 limit: 20
    t.boolean  "phone1_best",                        default: false, null: false
    t.string   "phone2",                 limit: 20
    t.boolean  "phone2_best",                        default: false, null: false
    t.string   "email1",                 limit: 255
    t.boolean  "email1_best",                        default: false, null: false
    t.string   "email2",                 limit: 255
    t.boolean  "email2_best",                        default: false, null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "current_partner"
    t.boolean  "ehr_extractor",                      default: false
    t.boolean  "ehr_helper",                         default: false
    t.boolean  "ehr_cqm",                            default: false
    t.string   "role_other"
    t.boolean  "site_contact_primary",               default: false
    t.boolean  "site_contact_secondary",             default: false
    t.boolean  "site_contact_champion",              default: false
  end

  add_index "personnels", ["practice_id"], name: "index_personnels_on_practice_id", using: :btree

  create_table "practice_surveys", force: :cascade do |t|
    t.integer  "practice_id",                        null: false
    t.string   "survey_key"
    t.integer  "last_page_saved"
    t.string   "name_survey_completer",              null: false
    t.string   "role_survey_completer"
    t.float    "pat_visits_week"
    t.integer  "pat_panel"
    t.float    "pat_panel_sz"
    t.float    "prov_visits_day"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "prac_race_white"
    t.integer  "prac_race_black"
    t.integer  "prac_race_aian"
    t.integer  "prac_race_asian"
    t.integer  "prac_race_pi"
    t.integer  "prac_race_other"
    t.integer  "prac_race_unk"
    t.integer  "prac_race_nocoll"
    t.integer  "prac_ethnicity_h"
    t.integer  "prac_ethnicity_nh"
    t.integer  "prac_ethnicity_unk"
    t.integer  "prac_ethnicity_nocoll"
    t.integer  "prac_pat_age_lt17"
    t.integer  "prac_pat_age_18to39"
    t.integer  "prac_pat_age_40to59"
    t.integer  "prac_pat_age_60to75"
    t.integer  "prac_pat_age_76andover"
    t.integer  "prac_payor_medicare"
    t.integer  "prac_payor_medicaid"
    t.integer  "prac_payor_dual"
    t.integer  "prac_payor_commercial"
    t.integer  "prac_payor_noins"
    t.integer  "prac_payor_other"
    t.integer  "prac_payor_specify"
    t.integer  "prac_under_ser"
    t.integer  "cpcq_strat_info_skills"
    t.integer  "cpcq_strat_oplead_rolemdl"
    t.integer  "cpcq_strat_sys_change"
    t.integer  "cpcq_strat_red_barr"
    t.integer  "cpcq_org_teams"
    t.integer  "cpcq_use_nonclinician"
    t.integer  "cpcq_authorize"
    t.integer  "cpcq_periodic_measurement"
    t.integer  "cpcq_reporting_measurement"
    t.integer  "cpcq_goals"
    t.integer  "cpcq_customize"
    t.integer  "cpcq_rapid_cycles"
    t.integer  "cpcq_design_care_clinician"
    t.integer  "cpcq_design_care_process"
    t.integer  "cpcq_priority"
    t.integer  "cqm_ivd"
    t.integer  "cqm_bp"
    t.integer  "cqm_statin"
    t.integer  "cqm_smokcess"
    t.integer  "prac_cqm_prac"
    t.integer  "prac_cqm_prov"
    t.integer  "prac_ehr_labs"
    t.integer  "prac_ehr_race_doc"
    t.integer  "prac_ehr_race_rpt"
    t.integer  "prac_ehr_age_doc"
    t.integer  "prac_ehr_age_rpt"
    t.integer  "prac_ehr_rpt_nonstd"
    t.integer  "prac_ehr_rpt_hist"
    t.integer  "prac_ehr_rpt_conf"
    t.integer  "prac_ehr_rpt_trust"
    t.integer  "prac_ehr_rpt_fee"
    t.integer  "prac_ehr_satisfaction_survey"
    t.integer  "prac_public_reporting"
    t.integer  "prac_discuss_data"
    t.integer  "prac_qual_report_data"
    t.integer  "prac_qual_report_rec"
    t.integer  "prac_qual_report_healthsystem"
    t.integer  "prac_qual_report_hie"
    t.integer  "prac_qual_report_primarycare"
    t.integer  "prac_qual_report_hospnetwor"
    t.integer  "prac_qual_report_external"
    t.integer  "prac_qual_report_pbrn"
    t.integer  "sna_freq"
    t.integer  "sna_helpful"
    t.integer  "sna_difference"
    t.integer  "prac_registry_ivd"
    t.integer  "prac_registry_hyp"
    t.integer  "prac_registry_chol"
    t.integer  "prac_registry_diab"
    t.integer  "prac_registry_prev"
    t.integer  "prac_registry_risk"
    t.integer  "prac_registry_none"
    t.integer  "prac_prev_guidelines_none"
    t.integer  "prac_prev_guidelines_posted"
    t.integer  "prac_prev_guidelines_agreed"
    t.integer  "prac_prev_guidelines_orders"
    t.integer  "prac_prev_guidelines_ehrprompts"
    t.integer  "prac_chronic_guidelines_none"
    t.integer  "prac_chronic_guidelines_posted"
    t.integer  "prac_chronic_guidelines_agreed"
    t.integer  "prac_chronic_guidelines_orders"
    t.integer  "prac_chronic_guidelines_ehrprompts"
    t.integer  "demo_prog_sim"
    t.integer  "demo_prog_cpci"
    t.integer  "demo_prog_tcpi"
    t.integer  "demo_prog_chw"
    t.integer  "demo_prog_pcmh"
    t.integer  "demo_prog_mh_collab"
    t.integer  "demo_prog_mh_riskred"
    t.integer  "demo_prog_other"
    t.string   "demo_prog_specify"
    t.integer  "prac_income_satisf"
    t.integer  "prac_income_quality"
    t.integer  "prac_income_perform"
    t.integer  "prac_perform_quality"
    t.integer  "prac_perform_resources"
    t.integer  "prac_revenue"
    t.integer  "prac_incentives_geographic"
    t.integer  "prac_incentives_primarycare"
    t.integer  "prac_incentives_carecoord"
    t.integer  "prac_incentives_other"
    t.string   "prac_incentives_specify"
    t.integer  "number_clinstaff"
    t.integer  "fte_clinstaff"
    t.integer  "number_offstaff"
    t.integer  "fte_offstaff"
    t.integer  "number_psychol"
    t.integer  "fte_psychol"
    t.integer  "number_sw"
    t.integer  "fte_sw"
    t.integer  "number_pharma"
    t.integer  "fte_pharma"
    t.integer  "number_other"
    t.integer  "fte_other"
    t.integer  "person_consult_front_office"
    t.integer  "person_consult_back_office"
    t.integer  "person_consult_office_manager"
    t.integer  "person_consult_nurse"
    t.integer  "person_consult_ma"
    t.integer  "person_consult_clinician"
    t.integer  "person_consult_other"
    t.string   "person_consult_other_specify"
  end

  add_index "practice_surveys", ["practice_id"], name: "index_practice_surveys_on_practice_id", using: :btree

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
    t.string   "city",                              limit: 50
    t.integer  "coach_id"
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
  add_foreign_key "practice_surveys", "practices"
  add_foreign_key "practices", "partners"
end
