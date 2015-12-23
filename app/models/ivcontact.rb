class Ivcontact < ActiveRecord::Base
	belongs_to :practice
	belongs_to :partner
  has_many :high_leverage_change_tests
  has_and_belongs_to_many :personnels
  has_paper_trail

  accepts_nested_attributes_for :high_leverage_change_tests, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true

  validates_presence_of :contact_dt

  def disruptions
    disruptions = ""
    disruptions += "New EHR*" if prac_change_ehr == 1
    disruptions += "New location*" if prac_change_newlocation == 1
    disruptions += "Lost clinician*" if prac_change_lost_clin == 1
    disruptions += "Lost staff*" if prac_change_lost_om == 1
    disruptions += "New affiliation*" if prac_change_boughtover == 1
    disruptions += "New billing*" if prac_change_billing == 1
    disruptions += "Other*" if prac_change_other == 1
    disruptions = disruptions.gsub(/(\w)(\*)(\w)/, '\1 - \3')
    disruptions.gsub(/\*$/, '')
  end

  def hlcs_making_progress
    lst = ""
    HLCS_SHORT.keys.each do |f|
      lst += "#{HLCS_SHORT[f]}; " if self.send(f) == PROGRESS_VALS["Making progress"]
    end
    if lst  == ""
      "None"
    else
      lst[0..-3]
    end
  end

  def topics_discussed
    lst = ""
    i = 1
    DISCUSSION_TOPICS.keys.each do |f|
      lst += "<abbr title = '#{DISCUSSION_TOPICS[f]}'>#{i}</abbr>; " if self.send(f)
      i += 1
    end
    if lst  == ""
      "None"
    else
      lst[0..-3] # eat the last semicolon/space
    end
  end

  HLCS_SHORT = {
    milestone_evidence_progress:  "Embed evidence",
    milestone_data_progress:      "Use data",
    milestone_qi_progress:        "QI process",
    milestone_atrisk_progress:    "Identify patients",
    milestone_task_progress:      "Define roles",
    milestone_selfmgmt_progress:  "Patient self-management",
    milestone_community_progress: "Community resources"
  }

  DISCUSSION_TOPICS = {
    topic_ehr_vendor:           "Work with EHR vendor",
    topic_3rdparty_vendor:      "Work with 3rd party vendor",
    topic_custom_query:         "Work on custom queries",
    topic_validate_data:        "Validate data",
    topic_meaningful_use:       "Meaningful Use",
    topic_cqm_report:           "Generate clinical quality measure reports",
    topic_abcs:                 "Submit ABCS measures to study team",
    topic_data_error:           "Data errors",
    topic_coding:               "Coding/IT needs",
    topic_hit_display:          "Create data displays",
    topic_reminder:             "Point of care reminders",
    topic_self_assessment:      "Review/collect Self-Assessment Survey",
    topic_share:                "Share best practices from another site",
    topic_planning:             "Discuss PDSA cycles or action planning",
    topic_workflow:             "Support workflow design",
    topic_leadership:           "Leadership meeting",
    topic_review_guideline:     "Review/discuss organizational guidelines",
    topic_brainstorm:           "Brainstorm ideas",
    topic_observe_flow:         "Observe team/clinic flow",
    topic_consensus:            "Facilitate a consensus discussion",
    topic_connect:              "Connect practice to another practice",
    topic_resource:             "Supply a tool or resource to support work",
    topic_discuss_measurement:  "Discuss value-based measurement",
    topic_roles:                "Identify roles/responsibilities",
    topic_qi_support:           "Provide QI meeting support",
    topic_huddle:               "Huddles",
    topic_review_data:          "Review data",
    topic_qi_display:           "Data displays/run-charts",
    topic_other:                "Other"
  }

  HIT_TIER_VALS = {
    "Tier 1" => 1,
    "Tier 2" => 2,
    "Tier 3" => 3,
    "Tier 4" => 4
  }

  HIT_QUALITY_VALS = {
    "Very confident" => 1,
    "Confident" => 2,
    "Somewhat confident" => 3,
    "Not confident" => 4,
  }

  CONTACT_TYPE_VALS = {
    "Quarterly in-person visit" => 1,
    "Other required contact" => 2,
    "Other ad-hoc contact" => 9
  }

  CONTACT_MODE_VALS = {
  	"In-person" => 1,
    "Phone" => 2,
    "Email" => 3,
  	"Online" => 4
  }

  CONTACT_SPECIFIC_VALS = {
		"Baseline" => 1,
		"Quarter 2" => 2,
		"Quarter 3" => 3,
		"Quarter 4" => 4,
		"Quarter 5" => 5,
  }

  Y1N2_VALS = {
  	"Yes" => 1,
  	"No" => 2
  }

  GYR_VALS = {
  	"Green" => 1,
  	"Yellow" => 2,
  	"Red" => 3
  }

  PROGRESS_VALS = {
  	"Not a priority" => 1,
  	"Planning, little/no progress" => 2,
  	"Making progress" => 3,
  	"Done/in place already" => 4
  }
end
