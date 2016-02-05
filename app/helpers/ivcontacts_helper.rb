=begin
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
    t.boolean  "topic_self_assessment"
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
    t.integer  "pcmha_1"
    t.integer  "pcmha_2"
    t.integer  "pcmha_3"
    t.integer  "pcmha_4"
    t.integer  "pcmha_5"
    t.integer  "pcmha_6"
    t.integer  "pcmha_7"
    t.integer  "pcmha_8"
    t.integer  "pcmha_9"
    t.integer  "pcmha_10"
    t.integer  "pcmha_11"
    t.integer  "pcmha_12"
    t.integer  "pcmha_13"
    t.integer  "pcmha_14"
    t.integer  "pcmha_15"
    t.integer  "pcmha_16"
    t.integer  "pcmha_17"
    t.integer  "pcmha_18"
    t.integer  "pcmha_19"
    t.integer  "pcmha_20"
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
    t.integer  "practice_id"
    t.boolean  "topic_review_guideline"
    t.boolean  "topic_discuss_measurement"
    t.string   "prac_change_ehr_which"
    t.string   "status_text"
    t.string   "smsvy_name"
    t.string   "smsvy_email"
    t.string   "hit_ehr_vendor"
    t.integer  "hit_tier"
    t.integer  "hit_quality"
    t.text     "hit_quality_explain"
    t.text     "observations"
    t.integer  "hit_coach"

=end

module IvcontactsHelper
  require "csv"
  def export_contacts(ivcontacts)
    to_export = {
                  id:                           'Database ID',
                  study_id:                     'Study ID',
                  name:                         'Practice Name',
                  drop_dt:                      'Date dropped',
                  coach_name:                   'Coach',
                  contact_type:                 'Type',
                  contact_dt:                   'Date',
                  contact_specific:             'Contact',
                  contact_mode:                 'Mode',
                  contact_duration:             'Duration (minutes)',
                  gyr:                          'GYR',
                  tier:                         'Change Capacity Tier',
                  pcmha_1:                      'QICA Guideline',
                  pcmha_2:                      'QICA Perf Meas',
                  pcmha_3:                      'QICA Reports',
                  pcmha_4:                      'QICA Responsibility',
                  pcmha_5:                      'QICA QI Activities',
                  pcmha_6:                      'QICA QI Conducted By',
                  pcmha_7:                      'QICA Data',
                  pcmha_8:                      'QICA Registries',
                  pcmha_9:                      'QICA Stratify',
                  pcmha_10:                     'QICA Visits',
                  pcmha_11:                     'QICA Non-Doc',
                  pcmha_12:                     'QICA Practice',
                  pcmha_13:                     'QICA Care Plans',
                  pcmha_14:                     'QICA Management',
                  pcmha_15:                     'QICA Values',
                  pcmha_16:                     'QICA Decisions',
                  pcmha_17:                     'QICA Self Management',
                  pcmha_18:                     'QICA Test Results',
                  pcmha_19:                     'QICA Specialty Care',
                  pcmha_20:                     'QICA Community Link',
                  disruptions:                  'Disruptions',
                  contact_comments:             'Comments'
                }
    to_export = to_export.merge(Ivcontact::DISCUSSION_TOPICS)
    to_export = to_export.merge(Ivcontact::HLCS_SHORT)
    csv_string = CSV.generate do |csv|
      csv << to_export.values
      ivcontacts.each do |cnt|
        wanted_attributes = Hash.new
        to_export.keys.each do |k|
          wanted_attributes[k] = case k
          when :id
            cnt.practice.id
          when :study_id
            cnt.practice.study_id
          when :name
            cnt.practice.name
          when :drop_dt
            cnt.practice.drop_dt
          when :coach_name
            cnt.practice.coach.name
          when :tier
            Ivcontact::TIER_LABELS.key(cnt.send(k))
          when :gyr
            Ivcontact::GYR_VALS.key(cnt.send(k))
          when :contact_mode
            Ivcontact::CONTACT_MODE_VALS.key(cnt.send(k))
          when :contact_type
            Ivcontact::CONTACT_TYPE_VALS.key(cnt.send(k))
          when :contact_specific
            Ivcontact::CONTACT_SPECIFIC_VALS.key(cnt.send(k))
          when :disruptions
            cnt.disruptions
          else
            if Ivcontact::HLCS_SHORT.keys.include?(k)
              Ivcontact::PROGRESS_VALS.key(cnt.send(k))
            else
              cnt.send(k)
            end
          end
        end # to_export.keys.each
        csv << wanted_attributes.values
      end # ivcontacts.each
    end # csv.generate
  end
end
